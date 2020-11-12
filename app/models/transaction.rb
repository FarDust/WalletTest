class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :origin_movement,
             class_name: 'Movement'
  belongs_to :target_movement,
             class_name: 'Movement'
end
