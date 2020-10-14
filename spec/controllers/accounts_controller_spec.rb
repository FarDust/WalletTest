# frozen_string_literal: true

require('rails_helper')

RSpec.describe(AccountsController, type: :controller) do
  describe 'GET #index' do
    login_user
    before { get :index }

    it { is_expected.to(respond_with(200)) }
  end

  describe 'GET #new' do
    login_user
    before { get :new }

    it { is_expected.to(respond_with(200)) }
  end

  describe 'POST #create failed' do
    login_user
    before do
      account = build(:account, account_type: nil)
      post :create, params: { account: account.as_json, format: :json }
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'POST #create success' do
    login_user
    before do
      account = build(:account)
      post :create, params: { account: account.as_json, format: :json }
    end

    it { is_expected.to(respond_with(:created)) }
  end

  describe 'POST #update success' do
    login_user
    before do
      @account = create(:account)
      put :update, params: { id: @account.id, account: { balance_cents: 400 } }
    end

    it { is_expected.to(redirect_to(@account)) }
  end

  describe 'POST #update failed' do
    login_user
    before do
      @account = create(:account)
      put :update, params: { id: @account.id, account: { account_type: nil }, format: :json }
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'DELETE #destroy failed' do
    login_user
    before do
      @account = create(:account)
      delete :destroy, params: { id: @account.id }
    end

    it { is_expected.to(redirect_to(accounts_path)) }
  end
end
