module SpecHelper
  def logged_in_user
    @user = FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Alphanumeric.alpha(number: 8))
    @auth_token = FactoryBot.create(:auth_token, user_id: @user.id)
    @token = @auth_token.token
    request.headers['Authorization'] = @token
  end

  def create_user
    @user = FactoryBot.create(:user, email: Faker::Internet.email, password: Faker::Alphanumeric.alpha(number: 8))
    @auth_token = FactoryBot.create(:auth_token, user_id: @user.id)
    @token = @auth_token.token
    request.headers['Authorization'] = @token
  end

  def user_params
    { 
      email: Faker::Internet.email, 
      password: Faker::Alphanumeric.alpha(number: 8), 
    }
  end
end
