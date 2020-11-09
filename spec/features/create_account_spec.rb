# frozen_string_literal: true

require 'rails_helper'

describe "create account process", type: :feature do
  include_context 'When authenticated'

  it "creat debt account" do
    visit '/accounts/new'
    within("form") do
      fill_in 'account_balance', with: '300'
      fill_in 'account_quota', with: '5000'
      find('#organizationSelect').find(:xpath, 'option[2]').select_option
    end
    click_button 'commit'
    expect(page).to have_css("p#notice", text: "Account was successfully created.")
  end

  
end