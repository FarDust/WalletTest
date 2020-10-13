# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DebtsController, type: :controller do
  describe 'GET #index' do
    login_user
    before { get :index } 

    it { should respond_with(200) }
  end

  describe 'GET #new' do
    login_user
    before { get :new }

    it { should respond_with(200) }
  end

  describe 'POST #create failed' do
    login_user
    before do
      debt = build(:debt, amount: nil)
      post :create, params: { debt: debt.as_json, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'POST #create success' do
    login_user
    before do
      debt = create(:debt, :for_user)
      post :create, params: { debt: debt.as_json, format: :json }
    end

    it { should respond_with(:created) }
  end

  describe 'POST #update success' do
    login_user
    before do
      @debt = create(:debt)
      put :update, params: { id: @debt.id, debt: { balance_cents: 400 } }
    end

    it { should redirect_to(@debt) }
  end

  describe 'POST #update failed' do
    login_user
    before do
      @debt = create(:debt)
      put :update, params: { id: @debt.id, debt: { amount: nil }, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'DELETE #destroy failed' do
    login_user
    before do
      @debt = create(:debt)
      delete :destroy, params: { id: @debt.id }
    end

    it { should redirect_to(debts_path) }
  end
end