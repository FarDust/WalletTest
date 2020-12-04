# frozen_string_literal: true

# == Schema Information
#
# Table name: natural_people
#
#  id         :bigint           not null, primary key
#  nombre     :string
#  apellido   :string
#  rut        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require('rails_helper')

RSpec.describe(NaturalPerson, type: :model) do
  context 'with attributes val' do
    it { is_expected.to(validate_presence_of(:nombre)) }
    it { is_expected.to(validate_presence_of(:apellido)) }
  end
end
