# frozen_string_literal: false

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MovementsHelper. For example:
#
# describe MovementsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe(MovementsHelper, type: :helper) do
  describe 'obtain destiantion movement' do
    it 'has correct target' do
      transaction = create(:transaction)
      transaction.save()
      expect(
        helper.get_destination(transaction.origin_movement).id
      ).to(be(transaction.target_movement.id))
    end

    it 'has correct origin' do
      transaction = create(:transaction)
      transaction.save()
      expect(
        helper.get_destination(transaction.target_movement).id
      ).to(be(transaction.origin_movement.id))
    end

    it 'returns' do
      movement = create(:movement)
      expect(helper.get_destination(movement).id).to(be(movement.id))
    end
  end
end
