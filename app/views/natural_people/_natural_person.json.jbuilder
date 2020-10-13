# frozen_string_literal: true

json.extract!(natural_person, :id, :nombre, :apellido,
              :rut, :created_at, :updated_at)
json.url(natural_person_url(natural_person, format: :json))
