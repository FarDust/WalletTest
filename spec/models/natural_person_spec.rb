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

  context 'when is created' do
    it 'render his public_identifier' do
      natural = create(:natural_person)
      expect(natural.public_identifier)
        .to(match(/#{natural.id}/))
    end
  end
end
