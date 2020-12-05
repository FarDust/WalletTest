# frozen_string_literal: false

require('rails_helper')

# rubocop:disable Metrics/BlockLength

RSpec.describe('routes for debts', type: :routing) do
  it 'routes /debts to debts#index' do
    expect(get: '/debts').to(route_to(
                               controller: 'debts',
                               action: 'index'
                             ))
  end

  it 'routes /debts/1 to debts#show' do
    expect(get: '/debts/1').to(route_to(
                                 controller: 'debts',
                                 action: 'show',
                                 id: '1'
                               ))
  end

  it 'routes /debts/new to debts#new' do
    expect(get: '/debts/new').to(route_to(
                                   controller: 'debts',
                                   action: 'new'
                                 ))
  end

  it 'routes /debts to debts#create' do
    expect(post: '/debts').to(route_to(
                                controller: 'debts',
                                action: 'create'
                              ))
  end

  it 'routes /debts/1/edit to debts#edit' do
    expect(get: '/debts/1/edit').to(route_to(
                                      controller: 'debts',
                                      action: 'edit',
                                      id: '1'
                                    ))
  end

  it 'routes /debts/1 to debts#update with put' do
    expect(put: '/debts/1').to(route_to(
                                 controller: 'debts',
                                 action: 'update',
                                 id: '1'
                               ))
  end

  it 'routes /debts/1 to debts#update with patch' do
    expect(patch: '/debts/1').to(route_to(
                                   controller: 'debts',
                                   action: 'update',
                                   id: '1'
                                 ))
  end

  it 'routes /debts/1 to debts#destroy' do
    expect(delete: '/debts/1').to(route_to(
                                    controller: 'debts',
                                    action: 'destroy',
                                    id: '1'
                                  ))
  end
end
# rubocop:enable Metrics/BlockLength
