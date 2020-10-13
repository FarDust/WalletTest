# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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
      category = build(:category, name: nil)
      post :create, params: { category: category.as_json, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'POST #create success' do
    login_user
    before do
      category = build(:category)
      post :create, params: { category: category.as_json, format: :json }
    end

    it { should respond_with(:created) }
  end

  describe 'POST #update success' do
    login_user
    before do
      @category = create(:category)
      put :update, params: { id: @category.id, category: { balance_cents: 400 } }
    end

    it { should redirect_to(@category) }
  end

  describe 'POST #update failed' do
    login_user
    before do
      @category = create(:category)
      put :update, params: { id: @category.id, category: { name: nil }, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'DELETE #destroy failed' do
    login_user
    before do
      @category = create(:category)
      delete :destroy, params: { id: @category.id }
    end

    it { should redirect_to(categories_path) }
  end
end