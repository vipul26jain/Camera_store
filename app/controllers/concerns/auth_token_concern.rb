module AuthTokenConcern
  extend ActiveSupport::Concern
  
  def generate_token params
    auth_token = UserService::Api::AuthTokens.create_login_token(params)
  end
end