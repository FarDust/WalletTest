# frozen_string_literal: false

json.extract!(transaction, :id, :user_id, :origin_movement_id,
              :target_movement_id, :created_at, :updated_at)
json.url(transaction_url(transaction, format: :json))
