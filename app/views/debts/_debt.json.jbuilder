# frozen_string_literal: true

json.extract!(debt, :id, :interest, :amount, :acreedor_id,
              :acreedor_type, :deudor_id, :deudor_type,
              :created_at, :updated_at)
json.url(debt_url(debt, format: :json))
