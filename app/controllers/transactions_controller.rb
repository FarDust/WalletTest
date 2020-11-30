# frozen_string_literal: false

class TransactionsController < AuthenticatedController
  before_action :set_transaction, only: %i[show]
  before_action :set_create_params, :set_movements, only: %i[create]
  load_and_authorize_resource

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = current_user.transactions
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @accounts = Account.where(user: current_user)
  end

  # POST /transactions
  # POST /transactions.json
  def create
    respond_to do |format|
      if valid_transactions?
        @trans = current_user.transactions.create!(movements_params)
        format.html { redirect_to(@trans, notice: 'Transaction created') }
        format.json { render(:show, status: :created, location: @trans) }
      else
        set_transaction_errors
        format.html { render(:new) }
        format.json { render(json: @trans, status: :unprocessable_entity) }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction)
          .permit(%i[comment category_id origin_account_id
                     target_account_id amount])
  end

  def set_movement_params(category_id, amount, comment)
    {
      category_id: category_id,
      amount: amount,
      comment: comment
    }
  end

  def set_create_params
    category_id = transaction_params['category_id']
    comment = transaction_params['comment']
    amount = transaction_params['amount']
    @origin_params = set_movement_params(category_id, - amount.to_f, comment)
    @target_params = set_movement_params(category_id, amount.to_f, comment)
  end

  def set_movements
    @origin_account = Account.find(transaction_params['origin_account_id'])
    @target_account = Account.find(transaction_params['target_account_id'])
    @origin_movement = @origin_account.movements.new(@origin_params)
    @target_movement = @target_account.movements.new(@target_params)
  end

  def movements_params
    {
      origin_movement_id: @origin_movement.id,
      target_movement_id: @target_movement.id
    }
  end

  def same_accounts?
    @origin_account.id == @target_account.id
  end

  def set_transaction_errors
    @transaction = current_user.transactions.new()
    @transaction.errors.merge!(@origin_movement.errors)
    @transaction.errors.merge!(@target_movement.errors)
    msg = 'Must te different than target account'
    @transaction.errors.add('Origin Account', msg) if same_accounts?
    @accounts = current_user.accounts
  end

  def save_movements
    @origin_movement.save
    @target_movement.save
  end

  def valid_transactions?
    if @origin_movement.valid? && @target_movement.valid? && !same_accounts?
      save_movements
      return true
    end
    false
  end
end
