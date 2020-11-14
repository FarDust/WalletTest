# frozen_string_literal: true

require('rails_helper')

RSpec.describe(NaturalPeopleController, type: :controller) do
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
      natural_person = build(:natural_person, nombre: nil)
      post :create, params: {
        natural_person: natural_person.as_json,
        format: :json
      }
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'POST #create success' do
    login_admin
    before do
      natural_person = build(:natural_person)
      post :create, params: {
        natural_person: natural_person.as_json,
        format: :json
      }
    end

    it { is_expected.to(respond_with(:created)) }
  end

  describe 'POST #update success' do
    login_admin
    before do
      natural_person = create(:natural_person)
      put :update, params: {
        id: natural_person.id,
        natural_person: { balance_cents: 400 }
      }
    end

    it { is_expected.to(respond_with(:redirect)) }
  end

  describe 'POST #update failed' do
    login_admin
    before do
      natural_person = create(:natural_person)
      put :update, params: {
        id: natural_person.id,
        natural_person: { nombre: nil },
        format: :json
      }
    end

    it { is_expected.to(respond_with(:unprocessable_entity)) }
  end

  describe 'DELETE #destroy failed' do
    login_admin
    before do
      natural_person = create(:natural_person)
      delete :destroy, params: { id: natural_person.id }
    end

    it { is_expected.to(redirect_to(natural_people_path)) }
  end
end
