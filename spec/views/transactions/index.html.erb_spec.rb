# frozen_string_literal: false

require('rails_helper')

# Deshabilitamos esta regla para poder hacer tests con @variable.

RSpec.describe('transactions/index') do # rubocop:disable RSpec/DescribeClass
  it 'display transaction account name' do
    transaction = create(:transaction)
    @transactions = transaction.user.transactions
    
    render(template: 'transactions/index')

    expect(rendered).to(match(transaction.origin_movement.account.name))
  end
end
