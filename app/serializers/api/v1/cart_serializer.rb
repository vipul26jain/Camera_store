module Api
  module V1
    class CartSerializer < AppSerializer
      attributes :id, :user_id, :product_id
      has_many   :products, serializer: ProductSerializer
	end
  end
end
