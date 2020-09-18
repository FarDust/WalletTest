# frozen_string_literal: true

# == Schema Information
#
# Table name: movements
#
#  id            :bigint           not null, primary key
#  category_id   :bigint           not null
#  account_id    :bigint           not null
#  fecha         :datetime
#  final_balance :integer
#  amount        :integer
#  comment       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Movement < ApplicationRecord
  belongs_to :category
  belongs_to :account
end
