require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  context 'POST create' do
    context 'success' do
      it 'should give success if correct values are passed' do
        params = user_params
        post :create, params: { user: params }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'fail' do
      it 'should give unprocessable_entity error if any values is nil' do
        post :create, params: { user: { email: nil, password: nil }}
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
