require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  context 'GET cart' do
    context 'not logged_in' do
      it 'should give unauthorized error when request without authorization token' do
        get :cart
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'logged_in' do
      context 'success' do
        it 'should give success if request is correct' do
          logged_in_user
          get :cart
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end