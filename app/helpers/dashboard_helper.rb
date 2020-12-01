require 'digest/md5'
module DashboardHelper

  def fancyUUID(identifier)
    Digest::MD5.hexdigest(identifier.to_s.rjust(64, '0'))
  end

  def get_money(movement, amount)
    Money.new(amount, movement.account.balance.currency)
  end

  def get_final_balances(account)
    account.movements.map { |movement| [movement.created_at, get_money(movement, movement.final_balance).fractional] }
  end

  def get_category_data(account)
    final_list = [
      {name: "Income", data: {}}, 
      {name: "Expense", data: {}}
    ]
    account.movements.group_by(&:category).each do |category, movements|
      movements.each do |movement|
        if !final_list[0].key?(category.name)
          final_list[0][:data][category.name.to_sym] = 0
          final_list[1][:data][category.name.to_sym] = 0
        end
        if movement.amount >= 0
          final_list[0][:data][category.name.to_sym] += get_money(movement, movement.amount).fractional
        else
          final_list[1][:data][category.name.to_sym] -= get_money(movement, movement.amount).fractional
        end
      end
    end
    final_list
  end

end
