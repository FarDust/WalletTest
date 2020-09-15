# frozen_string_literal: true

json.array!(@natural_people, partial: 'natural_people/natural_person',
                             as: :natural_person)
