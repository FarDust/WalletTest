# frozen_string_literal: true

class MovementsController < AuthenticatedController
  before_action :set_account
  before_action :set_movement, only: %i[show edit update destroy]

  # GET /movements
  # GET /movements.json
  def index
    @movements = Movement.where(account_id: params['account_id'])
  end

  # GET /movements/1
  # GET /movements/1.json
  def show
  end

  # GET /movements/new
  def new
    @movement = @account.movements.new
  end

  # GET /movements/1/edit
  def edit
  end

  # POST /movements
  # POST /movements.json
  def create
    @movement = @account.movements.new(movement_params)
    respond_to do |format|
      if @movement.save
        format.html do
          redirect_to(account_movements_path(@account),
                      notice: 'Movement was successfully created.')
        end
        format.json { render(json: @movement, status: :created) }
      else
        format.html { render(:new) }
        format.json do
          render(json: @movement.errors,
                 status: :unprocessable_entity)
        end
      end
    end
  end

  # PATCH/PUT /movements/1
  # PATCH/PUT /movements/1.json
  def update
    respond_to do |format|
      if @movement.update(movement_params)
        format.html do
          redirect_to(account_movements_path(@account),
                      status: :ok,
                      notice: 'Movement was successfully updated.')
        end
        format.json { render(json: @movement, status: :ok) }
      else
        format.html { render(:edit) }
        format.json do
          render(json: @movement.errors,
                 status: :unprocessable_entity)
        end
      end
    end
  end

  # DELETE /movements/1
  # DELETE /movements/1.json
  def destroy
    @movement.destroy
    respond_to do |format|
      msg = 'Movement was successfully destroyed.'
      format.html { redirect_to(account_movements_path(@account), notice: msg) }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movement
    @movement = Movement.find(params[:id])
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  # Only allow a list of trusted parameters through.
  def movement_params
    params.require(:movement).permit(:category_id,
                                     :final_balance, :amount, :comment)
  end
end
