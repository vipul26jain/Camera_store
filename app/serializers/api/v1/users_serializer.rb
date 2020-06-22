module Api
  module V1
    class UsersSerializer < AppSerializer
      		attributes :id, :email, :password, :password_confirmation, :auth_token
      		# has_many   :carts, class_name: 'Cart', serializer: CartSerializer
      		has_many   :products, through: :carts, class_name: 'Product', :foreign_key => :user_id, serializer: ProductSerializer
    end
  end
end
