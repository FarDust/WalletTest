# frozen_string_literal: false

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe(DashboardHelper, type: :helper) do
  describe 'obtain fancy uuid' do
    it 'generates correct hex value' do
      expect(helper.fancy_uuid(1)).to(eq('9a25b027482b37e047104e2e532cabae'))
    end
  end

  describe 'format money' do
    it 'obtain Money rails instance' do
      movement = create(:movement)
      expect(helper.get_money(movement, 2)).to(be_instance_of(Money))
    end

    it 'obtain amount when needed' do
      movement = create(:movement)
      expect(helper.get_amount(movement)).to(be_instance_of(Integer))
    end

    it 'gets a value when needed' do
      movement = create(:movement)
      expect(helper.get_amount(movement)).to(be(2323))
    end
  end

  describe 'category data chart' do
    # rubocop:disable RSpec/MultipleExpectations
    it 'has a list of shape' do
      result_list = helper.send(:set_data_list)
      expect(result_list.length()).to(be(2))
      expect(result_list[0].key?(:data)).to(be(true))
      expect(result_list[0].key?(:name)).to(be(true))
      expect(result_list[1].key?(:data)).to(be(true))
      expect(result_list[1].key?(:name)).to(be(true))
    end
    # rubocop:enable RSpec/MultipleExpectations

    it 'creates a list with valid data' do
      account, movement1, = complete_account()
      final_list = helper.get_category_data(account)
      expect(final_list[0][:data][movement1.category.name.to_sym]).to(be(2323))
    end

    it 'has 2 movements' do
      account, = complete_account()
      balances = helper.get_final_balances(account)
      expect(balances.length).to(be(2))
    end
  end
end
