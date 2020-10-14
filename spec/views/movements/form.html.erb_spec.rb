# frozen_string_literal: false

require('rails_helper')

RSpec.describe('movements/new') do
  it 'display credit movement form' do
    @account = build(:account, account_type: 'credit', balance_cents: -3000, quota: '3000')
    @account.save
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it 'display debt movement form' do
    @account = build(:account, account_type: 'debt')
    @account.save
    @movement = Movement.new
    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it 'display common movement form' do
    @account = build(:account, account_type: 'common')
    @account.save
    @movement = Movement.new

    render(template: 'movements/new')

    expect(rendered).to(match(/Movement Management Form/))
  end

  it "dosen't display default movement form" do
    @account = build(:account, account_type: 'test')
    @account.save
    @movement = Movement.new

    expect { render(template: 'movements/new') }.to(
      raise_exception(ActionView::Template::Error)
    )
  end
end
