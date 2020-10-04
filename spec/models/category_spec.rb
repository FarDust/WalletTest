# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#
require('rails_helper')

RSpec.describe(Category, type: :model) do
  context 'with attributes val' do
    it { is_expected.to(validate_presence_of(:name)) }
  end

  context 'when create category' do
    it 'use valid data' do
      category = build(:category)
      expect(category).to(be_valid)
    end

    it 'use invalid data' do
      category = build(:category, name: nil)
      expect(category).not_to(be_valid)
    end
  end
end
