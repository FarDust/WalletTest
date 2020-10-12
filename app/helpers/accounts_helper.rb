# frozen_string_literal: true

module AccountsHelper
  def account_form(account)
    case account.account_type
    when Account::DEBT_TYPE
      'debt_form'
    when Account::CREDIT_TYPE
      'credit_form'
    when Account::COMMON_TYPE
      'common_form'
    else
      'form'
    end
  end
end
