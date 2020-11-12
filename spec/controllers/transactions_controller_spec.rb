# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(TransactionsController, type: :controller) do
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

  describe 'GET #show' do
    login_user
    before do
      transaction = create(:transaction)
      get(:show, params: { id: transaction.id })
    end

    it { is_expected.to(respond_with(200)) }
  end

  describe 'POST #create failed with no amount' do
    login_user
    before do
      origin = create(:account)
      target = create(:account)
      post :create,
           params: {
             transaction: {
               amount: 0,
               origin_account_id: origin.id,
               target_account_id: target.id
             }
           },
           format: :json
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'POST #create failed with same accounts' do
    login_user
    before do
      origin = create(:account)
      post :create,
           params: {
             transaction: {
               amount: 100,
               origin_account_id: origin.id,
               target_account_id: origin.id
             }
           },
           format: :json
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'POST #create success' do
    login_user
    before do
      origin = create(:account)
      target = create(:account)
      category = create(:category)
      post :create,
           params: {
             transaction: {
               amount: 100,
               origin_account_id: origin.id,
               target_account_id: target.id,
               category_id: category.id
             }
           },
           format: :json
    end

    it { is_expected.to(respond_with(:created)) }
  end
end
