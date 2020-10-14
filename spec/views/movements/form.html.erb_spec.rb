# frozen_string_literal: false

require('rails_helper')

RSpec.describe('form', type: :view) do
  it 'display credit movement form' do
    @account = create(:account, account_type: 'credit')
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Credit Form/))
  end

  it 'display debt movement form' do
    @account = create(:account, account_type: 'debt')
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Debt Form/))
  end

  it 'display common movement form' do
    @account = create(:account, account_type: 'common')
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it 'display default movement form' do
    @account = create(:account, account_type: 'test')
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/Create Movement/))
  end
end
