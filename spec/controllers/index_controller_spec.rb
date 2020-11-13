# frozen_string_literal: false

require('rails_helper')

RSpec.describe(IndexController, type: :controller) do
  describe 'GET /' do
    login_admin

    context 'with login user' do
      it 'returns 200 OK' do
        get(:index)
        expect(response).to(have_http_status(:success))
      end
    end
  end

  describe 'GET root' do
    context 'without login user' do
      it 'returns 200 OK' do
        get(:index)
        expect(response).to(have_http_status(:success))
      end
    end
  end
end
