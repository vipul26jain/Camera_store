module Api
  module V1
    class UsersController < Api::V1::ApiController

      def cart
        begin
          carts = current_user.carts
          if current_user
            render_success_response({
                user: single_serializer.new(current_user, serializer: UsersSerializer)
            })
          else
            render json: {error: "Cart is empty"}, status: :not_found
          end
        rescue => e
              render json: {error: e.message}, status: :unprocessable_entity
        end
      end

        private
      end
  end
end
