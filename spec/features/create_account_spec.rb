# frozen_string_literal: true

require 'rails_helper'

describe 'create account process', type: :feature do
  include_context 'when authenticated'
  before do
    create(:category)
    click_on 'Accounts'
    click_on 'New Account'
  end

  it 'create debt account with possitve balance' do
    within('form#create_form') do
      fill_in 'account_balance', with: '300'
      select 'debt', from: 'account_account_type'
    end
    click_on 'commit'
    expect(page).to(have_css('p#notice'))
  end

  it 'create debt account wiht negative balance' do
    within('form#create_form') do
      fill_in 'account_balance', with: '-300'
      select 'debt', from: 'account_account_type'
    end
    click_on 'commit'
    expect(page).to(have_css('div#error_explanation'))
  end

  it 'create credit account wiht postive balance' do
    within('form#create_form') do
      fill_in 'account_balance', with: '300'
      fill_in 'account_quota', with: '300'
      select 'credit', from: 'account_account_type'
    end
    click_on 'commit'
    expect(page).to(have_css('div#error_explanation'))
  end

  it 'create credit account wiht balance higher than quota' do
    within('form#create_form') do
      fill_in 'account_balance', with: '-300'
      fill_in 'account_quota', with: '100'
      select 'credit', from: 'account_account_type'
    end
    click_on 'commit'
    expect(page).to(have_css('div#error_explanation'))
  end
end
