# frozen_string_literal: false

require('rails_helper')

RSpec.describe('routes for Users', type: :routing) do
  it 'routes /users/sign_in to the users/session controller' do
    expect(get('/users/sign_in')).to(route_to('users/sessions#new'))
  end

  it 'routes /users/sign_up to the devise controller' do
    expect(get('/users/sign_up')).to(route_to('devise/registrations#new'))
  end

  it 'routes /users/password/new to the devise/passwords controller' do
    expect(get('/users/password/new')).to(route_to('devise/passwords#new'))
  end

  it 'routes /users/sign_out to the users/session controller' do
    expect(delete('/users/sign_out')).to(route_to('users/sessions#destroy'))
  end
end
