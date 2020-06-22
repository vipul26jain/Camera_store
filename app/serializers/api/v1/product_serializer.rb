module Api
  module V1
    class ProductSerializer < AppSerializer
      attributes :id, :name, :description, :make, :product_type
	end
  end
end
