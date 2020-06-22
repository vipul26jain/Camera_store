module UserService::Api
  module AuthTokens

    module_function
    def create_login_token(options = {})
      auth_token = AuthToken.create!(:user_id => options[:user_id], :platform => options[:platform], :device_type => options[:device_type], :device_udid_number => options[:device_udid_number],:expire_at => 30.days.from_now)
      return auth_token
    end
  end
end