# frozen_string_literal: false

require 'digest/md5'
module DashboardHelper
  def fancy_uuid(identifier)
    Digest::MD5.hexdigest(identifier.to_s.rjust(64, '0'))
  end

  def get_money(movement, amount)
    Money.new(amount, movement.account.balance.currency)
  end

  def get_final_balances(account)
    account.movements.map do |movement|
      [
        movement.created_at,
        get_money(movement, movement.final_balance).fractional
      ]
    end
  end

  def get_amount(movement)
    get_money(
      movement,
      movement.amount
    ).fractional
  end

  def get_category_data(account)
    final_list = set_data_list
    for group in account.movements.group_by(&:category) do
      add_category(final_list, group[0])
      for movement in group[1] do
        add_values(final_list, movement, group[0])
      end
    end
    final_list
  end

  private

  def set_data_list
    [
      { name: 'Income', data: {} },
      { name: 'Expense', data: {} }
    ]
  end

  def add_values(final_list, movement, category)
    final_list[
      movement.amount >= 0 ? 0 : 1
    ][:data][category.name.to_sym] += get_amount(movement).abs
  end

  def add_category(final_list, category)
    final_list[0][:data][category.name.to_sym] = 0
    final_list[1][:data][category.name.to_sym] = 0
  end
end
