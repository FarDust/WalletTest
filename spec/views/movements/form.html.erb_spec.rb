# frozen_string_literal: false

require('rails_helper')

RSpec.describe("movements/new") do
  it 'display credit movement form' do
    @account = build(:account, account_type: 'credit')
    @account.save
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Credit Form/))
  end

  it 'display debt movement form' do
    @account = build(:account, account_type: 'debt')
    @account.save
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Debt Form/))
  end

  it 'display common movement form' do
    @account = build(:account, account_type: 'common')
    @account.save
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it 'display default movement form' do
    @account = build(:account, account_type: 'test')
    @account.save
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/Create Movement/))
  end
end
