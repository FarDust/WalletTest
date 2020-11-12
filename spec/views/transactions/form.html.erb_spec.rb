# frozen_string_literal: false

require('rails_helper')


RSpec.describe('transactions/new') do # rubocop:disable RSpec/DescribeClass
  it 'display transaction form' do
    account = create(:account)
    @accounts = account.user.accounts
    @transaction = build(:transaction)
    
    render(template: 'transactions/new')

    expect(rendered).to(match(/Creating a new transaction/))
  end
end
