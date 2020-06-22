module Api
  module V1  
    class ProductsController < Api::V1::ApiController

      # Get all products
      def index
        begin
          products = Product.all
          if products
            render_success_response({
                products: array_serializer.new(products, serializer: ProductSerializer)
            })
          else
            render json: {error: "Couldn't find products"}, status: :not_found
          end
        rescue => e
              render json: {error: e.message}, status: :unprocessable_entity
        end
      end

      # Add single product to user cart
      def add_product_to_cart
        begin
          if params[:product_id].present?
            @product = Product.find(params[:product_id])
            if @product.present?
              if !Cart.find_by(user_id: current_user.id, product_id: @product.id).present?
                @cart = Cart.new
                @cart.user_id = current_user.id
                @cart.product_id = @product.id
                @cart.save!
                render_success_response("Product successfully added to the Cart.")
              else
                render_success_response("Product is already present in your cart")
              end
            else
              render json: {error: "Couldn't find product"}, status: :not_found
            end
          else
            render json: {error: "Couldn't find product"}, status: :not_found
          end
        rescue => e
          render json: {error: e.message}, status: :unprocessable_entity
        end
      end
      
      private
    end
  end
end