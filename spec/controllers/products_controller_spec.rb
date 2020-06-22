require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  context 'GET index' do
    context 'not logged_in' do
      it 'should give unauthorized error when request without authorization token' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context 'logged_in' do
      context 'success' do
        it 'should give success if authorization token is correct' do
          logged_in_user
          get :index
          expect(response).to have_http_status(:ok)
        end
      end
    end   
  end
  
end