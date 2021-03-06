# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(AccountsController, type: :controller) do
  describe 'GET #index' do
    login_admin
    before { get :index }

    it { is_expected.to(respond_with(200)) }
  end

  describe 'GET #new' do
    login_admin
    before { get :new }

    it { is_expected.to(respond_with(200)) }
  end

  describe 'POST #create failed' do
    login_admin
    before do
      account = build(:account, account_type: nil)
      post :create, params: { account: account.as_json, format: :json }
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'POST #create success' do
    login_admin
    before do
      # rubocop:disable RSpec/NamedSubject
      np = create(:natural_person, related_account: subject.current_user.id)
      # rubocop:enable RSpec/NamedSubject
      account = build(:account)
      request_params = account.as_json
      request_params[:currency] = request_params[:balance_currency]
      post :create, params: { account: request_params, format: :json }
    end

    it { is_expected.to(respond_with(:created)) }
  end

  describe 'POST #update success' do
    login_admin
    before do
      # rubocop:disable RSpec/NamedSubject
      account = create(:account, user: subject.current_user)
      # rubocop:enable RSpec/NamedSubject
      put :update, params: { id: account.id, account: { balance_cents: 400 } }
    end

    it { is_expected.to(redirect_to(Account.last)) }
  end

  describe 'POST #update failed' do
    login_admin
    before do
      # rubocop:disable RSpec/NamedSubject
      account = create(:account, user: subject.current_user)
      # rubocop:enable RSpec/NamedSubject
      put :update,
          params: { id: account.id, account: { balance: nil } },
          format: :json
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'DELETE #destroy failed' do
    login_admin
    before do
      # rubocop:disable RSpec/NamedSubject
      account = create(:account, user: subject.current_user)
      # rubocop:enable RSpec/NamedSubject
      delete :destroy, params: { id: account.id }
    end

    it { is_expected.to(redirect_to(accounts_path)) }
  end
end
