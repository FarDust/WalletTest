# frozen_string_literal: true

json.array!(@movements, partial: 'movements/movement', as: :movement)
