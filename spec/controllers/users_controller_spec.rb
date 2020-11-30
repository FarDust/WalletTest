# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(UsersController, type: :controller) do
  describe 'GET #index' do
    login_admin
    before { get :index }

    it { is_expected.to(respond_with(200)) }
  end

  describe 'GET #index as not admin' do
    login_user
    before { get :index }

    it { is_expected.to(respond_with(302)) }
  end

  describe 'POST #enable success' do
    login_admin
    before do
      user = create(:user)
      put :enable, params: { id: user.id }
    end

    it { is_expected.to(redirect_to(users_path)) }
  end

  describe 'DELETE #destroy success' do
    login_admin
    before do
      user = create(:user)
      account = create(:credit_account, balance: -100, quota: 200, user: user)
      create(:movement, account: account, amount: 100)
      delete :destroy, params: { id: user.id }
    end

    it { is_expected.to(redirect_to(users_path)) }
  end

  describe 'DELETE #destroy failed' do
    login_admin
    before do
      user = create(:user)
      account = create(:credit_account, balance: -100, quota: 200, user: user)
      create(:movement, account: account, amount: 80)
      delete :destroy, params: { id: user.id }
    end

    it { is_expected.to(redirect_to(users_path)) }
  end
end
