class Product < ApplicationRecord
	#Associations
	belongs_to		:product_type, class_name: 'MasterType'
	has_many		:carts, class_name: 'Cart'
end
