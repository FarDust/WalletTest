# frozen_string_literal: true

json.extract!(movement, :id, :category_id, :account_id,
              :fecha, :final_balance, :amount,
              :comment, :created_at, :updated_at)
json.url(movement_url(movement, format: :json))
