# frozen_string_literal: false

require('rails_helper')

# Deshabilitamos esta regla para poder hacer tests con @variable.
# rubocop:disable RSpec/InstanceVariable

RSpec.describe('movements/new') do # rubocop:disable RSpec/DescribeClass
  it 'display credit movement form' do
    @account = create(:account, account_type: 'credit',
                                balance_cents: -3000, quota: '3000')
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it 'display debt movement form' do
    @account = create(:account, account_type: 'debt')
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it 'display common movement form' do
    @account = create(:account, account_type: 'common')
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it 'display default movement form' do
    @account = build(:account, account_type: 'test')
    @account.save
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/New Movement/))
  end
end

# rubocop:enable RSpec/InstanceVariable
