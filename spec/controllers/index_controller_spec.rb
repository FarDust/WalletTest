# frozen_string_literal: false

require('rails_helper')

RSpec.describe(IndexController, type: :controller) do
  describe 'GET /' do
    login_user

    context 'with login user' do
      it 'returns 200 OK' do
        get(:index)
        expect(response).to(have_http_status(:success))
      end
    end
  end

  describe 'GET /' do
    context 'without login user' do
      it 'returns 302 redirect' do
        get(:index)
        expect(response).to(have_http_status(302))
      end
    end
  end
end
