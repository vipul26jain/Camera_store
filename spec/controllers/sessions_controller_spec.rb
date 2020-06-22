# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  context 'DELETE logout' do
    context 'not logged_in' do
      it 'should give unauthorized if auth_token not present' do
        delete :logout
        @auth_token = AuthToken.find_by(token: @token)
        expect(@auth_token).to eq nil
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'logged_in' do
      context 'failure' do
        it 'should give error if auth token of the user is invalid' do
          logged_in_user
          request.headers['Authorization'] = Faker::Alphanumeric.alphanumeric
          @auth_token = AuthToken.find_by(token: @token)
          delete :logout
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'success' do
        it 'should give not_found if requested id is incorrect' do
          logged_in_user
          request.headers['Authorization'] = @token
          delete :logout
          expect(AuthToken.find_by(token: @token)).to eq nil
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
  context 'POST login' do
    context 'success' do
      it 'should give success when request for correct user with valid credentials when logged_in with email' do
        create_user
        allow(UserService::Api::AuthTokens).to receive(:create_login_token).and_return(@stubbed_response)
        post :login, params: { user: { email: @user.email, password: @user.password} }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'fail' do
      it 'should give unauthorized error when request with invalid credentials' do
        create_user
        request.headers['Authorization'] = @token
        allow(UserService::Api::AuthTokens).to receive(:create_login_token).and_return(@stubbed_response)
        post :login, params: { user: { email: Faker::Internet.email, password: Faker::Alphanumeric.alphanumeric} }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end