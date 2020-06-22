class ProductsController < ApplicationController
  # before_action :authenticate_user!

  def index
  	@products = Product.all
    render json: {products: @products}, status: :ok
  end
end
