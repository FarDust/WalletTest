# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NaturalPeopleController, type: :controller do
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
      natural_person = build(:natural_person, nombre: nil)
      post :create, params: { natural_person: natural_person.as_json, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'POST #create success' do
    login_user
    before do
      natural_person = build(:natural_person)
      post :create, params: { natural_person: natural_person.as_json, format: :json }
    end

    it { should respond_with(:created) }
  end

  describe 'POST #update success' do
    login_user
    before do
      @natural_person = create(:natural_person)
      put :update, params: { id: @natural_person.id, natural_person: { balance_cents: 400 } }
    end

    it { should redirect_to(@natural_person) }
  end

  describe 'POST #update failed' do
    login_user
    before do
      @natural_person = create(:natural_person)
      put :update, params: { id: @natural_person.id, natural_person: { nombre: nil }, format: :json }
    end

    it { should respond_with(:unprocessable_entity) }
  end

  describe 'DELETE #destroy failed' do
    login_user
    before do
      @natural_person = create(:natural_person)
      delete :destroy, params: { id: @natural_person.id }
    end

    it { should redirect_to(natural_people_path) }
  end
end