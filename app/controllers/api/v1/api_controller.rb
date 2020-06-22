# frozen_string_literal: true

class Api::V1::ApiController < ActionController::API
  include ApplicationMethods
  attr_reader :current_user
  before_action :authenticate_user!

  protected

  # derive the model name from the controller. egs UsersController will return User
  def self.permission
    name = begin
             self.name.gsub('Controller', '').singularize.split('::').last.constantize.name
           rescue StandardError
             nil
           end
  end


  def verify_auth_token
    @auth_token = AuthToken.find_by(token: request.headers['Authorization'])
    render json: { error: 'Invalid token' }, status: :unauthorized unless @auth_token.present?
  end

  private

  def authenticate_user!
    token = request.headers['Authorization']
    if !token.nil?
      @current_user = User.eager_load(:auth_tokens).where('auth_tokens.token = ?', token.to_s).last
    end
    render_unauthorized_response unless @current_user
  end
end
