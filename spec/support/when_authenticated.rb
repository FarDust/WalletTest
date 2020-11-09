# frozen_string_literal: false


## sacado de https://stackoverflow.com/questions/32479612/rspec-capybara-loginuser-not-working
RSpec.shared_context 'When authenticated' do
  before do
    create(:user, email: 'user@example.com')
    authenticate
  end
  
  def authenticate
    visit "/users/sign_in"
    within('form#new_user') do
      fill_in 'user_email', :with => "user@example.com"
      fill_in 'user_password', :with => "123456"
    end
    click_on 'commit'
    end
  end