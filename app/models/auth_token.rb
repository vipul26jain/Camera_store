class AuthToken < ApplicationRecord
	belongs_to :user
	after_initialize :defaults
	validates_presence_of :user_id
	validates_presence_of :expire_at
	validates_uniqueness_of :token

  def defaults
    self.token ||= SecureRandom.urlsafe_base64(8)
  end
end