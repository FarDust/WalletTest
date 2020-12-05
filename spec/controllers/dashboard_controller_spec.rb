# frozen_string_literal: false

require('rails_helper')

RSpec.describe(DashboardController, type: :controller) do
  describe 'GET #index' do
    login_user
    before { get :index }

    it { is_expected.to(respond_with(200)) }
  end

  describe 'GET #show' do
    login_user
    before do
      account = create(:account)
      account.save()
      get :show, params: { id: account.id }
    end

    it { is_expected.to(respond_with(200)) }
  end
end
