# frozen_string_literal: false

require('rails_helper')

RSpec.describe("accounts/index") do
  it 'displays all the accounts' do
    assign(:accounts, [])

    render

    expect(rendered).to match /Accounts/
  end
end
