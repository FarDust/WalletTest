# frozen_string_literal: true

require('rails_helper')

RSpec.describe(DebtsController, type: :controller) do
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
      debt = build(:debt, amount: nil)
      post :create, params: { debt: debt.as_json, format: :json }
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'POST #create success' do
    login_admin
    before do
      debt = create(:debt, :for_user)
      post :create, params: { debt: debt.as_json, format: :json }
    end

    it { is_expected.to(respond_with(:created)) }
  end

  describe 'POST #update success' do
    login_admin
    before do
      # rubocop:disable RSpec/NamedSubject
      debt = create(:debt, acreedor: subject.current_user)
      # rubocop:enable RSpec/NamedSubject
      put :update, params: { id: debt.id, debt: { balance_cents: 400 } }
    end

    it { is_expected.to(redirect_to(Debt.last)) }
  end

  describe 'POST #update failed' do
    login_admin
    before do
      # rubocop:disable RSpec/NamedSubject
      debt = create(:debt, acreedor: subject.current_user)
      # rubocop:enable RSpec/NamedSubject
      put :update, params: { id: debt.id, debt: { amount: nil }, format: :json }
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'DELETE #destroy failed' do
    login_admin
    before do
      # rubocop:disable RSpec/NamedSubject
      debt = create(:debt, acreedor: subject.current_user)
      # rubocop:enable RSpec/NamedSubject
      delete :destroy, params: { id: debt.id }
    end

    it { is_expected.to(redirect_to(debts_path)) }
  end
end
