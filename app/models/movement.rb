# frozen_string_literal: true

# == Schema Information
#
# Table name: movements
#
#  id          :bigint           not null, primary key
#  account_id  :bigint           not null
#  balance     :integer
#  amount      :integer
#  comment     :text
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Movement < ApplicationRecord
  belongs_to :category
  belongs_to :account
end
