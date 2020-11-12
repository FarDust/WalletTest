# frozen_string_literal: false

json.array!(@transactions,
            partial: 'transactions/transaction',
            as: :transaction)
