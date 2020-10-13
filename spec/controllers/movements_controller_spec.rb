# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovementsController, type: :controller do
  describe 'GET #index' do
    login_user
    before do
      @account = build(:account)
      @account.save
      get :index, params: { account_id: @account.id }
    end

    it { should respond_with(200) }
  end

  describe 'GET #new' do
    login_user
    before do
      @account = build(:account)
      @account.save
      @movement = Movement.new
      get :new, params: { account_id: @account.id }
    end

    it { should respond_with(200) }
  end

  describe 'POST #create failed' do
    login_user
    before do
      @account = build(:account)
      @account.save
      movement = @account.movements.create(amount: 300)
      post :create, params: { account_id: @account.id, movement: movement.as_json, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'POST #create success' do
    login_user
    before do
      @account = build(:account)
      @account.save
      category = build(:category)
      category.save
      movement = @account.movements.create(amount: 300, category: category)
      post :create, params: { account_id: @account.id, movement: movement.as_json }
    end

    it { should redirect_to(account_movements_path(@account)) }
  end

  describe 'POST #update success' do
    login_user
    before do
      @account = build(:account)
      @account.save
      category = build(:category)
      category.save
      movement = @account.movements.create!(amount: 300, category: category)
      put :update, params: { account_id: @account.id, id: movement.id, movement: movement.as_json }
    end

    it { should redirect_to(account_movements_path(@account)) }
  end

  describe 'POST #update failed' do
    login_user
    before do
      @account = build(:account)
      @account.save
      category = build(:category)
      category.save
      movement = @account.movements.create!(amount: 300, category: category)
      put :update, params: { account_id: @account.id, id: movement.id, movement: { amount: 0 }, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'POST #update failed' do
    login_user
    before do
      @account = build(:account)
      @account.save
      category = build(:category)
      category.save
      movement = @account.movements.create!(amount: 300, category: category)
      delete :destroy, params: { account_id: @account.id, id: movement.id }
    end

    it { should redirect_to(account_movements_path(@account)) }
  end
end