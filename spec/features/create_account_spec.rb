# frozen_string_literal: true

require 'rails_helper'

describe 'create account process', type: :feature do
  include_context 'when authenticated'
  before do
    create(:category)
    visit('/accounts/new')
  end

  it 'create debt account' do
    within('form#create_form') do
      fill_in 'account_balance', with: '300'
      fill_in 'Quota', with: '5000'
    end
    click_on 'commit'
    expect(page).to(have_css('p#notice'))
  end
end
