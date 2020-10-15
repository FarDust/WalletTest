# frozen_string_literal: false

require('rails_helper')

# Deshabilitamos esta regla para poder hacer tests con @variable.

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

  it "doesn't display default movement form" do
    @account = create(:account, account_type: 'test')
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/New Movement/))
  end
end
