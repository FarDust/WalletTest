# frozen_string_literal: false

require('rails_helper')

RSpec.describe('index view', type: :view) do
  it 'display logout' do
    current_user = User.create(email: 'test@test.cl', password: '123456')
    render(partial: 'layouts/navigation',
           locals: { current_user: current_user })
    expect(rendered).to(match(/Logout/))
  end

  it 'display Sign In' do
    render(partial: 'layouts/navigation')
    expect(rendered).to(match(/SignIn/))
  end
end
