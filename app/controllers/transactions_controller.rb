class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
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

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    category_id = transaction_params['category_id']
    comment = transaction_params['comment']
    amount = transaction_params["amount"]

    # Creamos un movimiento con valor negativo a la cuenta origen y con valor positivo a la cuenta de destino.
    origin_params = {"category_id" => category_id, "amount" => '-' + amount, "comment" => comment}
    target_params = {"category_id" => category_id, "amount" =>       amount, "comment" => comment}

    @origin_movement = Account.find(transaction_params['origin_account_id']).movements.new(origin_params)
    @target_movement = Account.find(transaction_params['target_account_id']).movements.new(target_params)

    respond_to do |format|
      if @origin_movement.valid? && @target_movement.valid?
        # Nos aseguramos de crear los movmientos sólo cuando ambas son movimientos válidos. 
        @origin_movement.save
        @target_movement.save
        
        # Creamos una transacción con referencia a ambas transacciones.
        transac_params = {"user_id" => current_user, "origin_movement_id" => @origin_movement.id, "target_movement_id" => @target_movement.id}
        @transaction = current_user.transactions.new(transac_params)
        
        if @transaction.save
          format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
          format.json { render :show, status: :created, location: @transaction }
        else
          # Esto lo necesitamos sólo para poder mostrar el "select" de cuentas de nuevo.
          @accounts = Account.where(user: current_user)
          
          format.html { render :new }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      else
        @accounts = Account.where(user: current_user)

        # Creamos un gran objecto de errores incluyendo los errores generado por los movimientos.
        @transaction = current_user.transactions.new()
        @transaction.errors.merge!(@origin_movement.errors)
        @transaction.errors.merge!(@target_movement.errors)

        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:comment, :category_id, :user_id, :origin_movement_id, :target_movement_id, :origin_account_id, :target_account_id, :amount)
    end
end
