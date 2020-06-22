class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :auth_tokens, dependent: :destroy
  has_many  :carts, class_name: 'Cart'
  has_many :products, through: :carts, class_name: 'Product', :foreign_key => :user_id

  attr_accessor :auth_token

  def auth_token
    self.auth_tokens.last.token
  end
end
