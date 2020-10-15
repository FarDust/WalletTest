# frozen_string_literal: true

module AccountsHelper
  def account_form(account)
    case account.account_type
    when Account::DEBT_TYPE
      'movements/debt_form'
    when Account::CREDIT_TYPE
      'movements/credit_form'
    when Account::COMMON_TYPE
      'movements/common_form'
    else
      'movements/form'
    end
  end
end
