# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#
class Category < ApplicationRecord
  validates :name, presence: true
  has_many :movements, dependent: :restrict_with_error
end
