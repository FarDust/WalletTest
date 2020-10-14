# frozen_string_literal: false

require('rails_helper')

RSpec.describe('index', type: :view) do
  it 'displays all the accounts' do
    assign(:accounts, [])

    render(template: 'accounts/index')

    expect(rendered).to(match(/Accounts/))
  end
end