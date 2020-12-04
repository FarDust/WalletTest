# frozen_string_literal: true

class DebtsController < AuthenticatedController
  before_action :set_debt, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /debts
  # GET /debts.json
  def index
    @debts = Debt.where(acreedor_id: current_user.id, acreedor_type: 'User')
                 .or(Debt.where(deudor_id: current_user.id,
                                deudor_type: 'User'))
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts
  # POST /debts.json
  def create
    @debt = Debt.new(debt_params)
    # print('Tipo de deudor', @debt.deudor_id, ' y tmbn ', @debt.deudor_type)
    approved = (@debt.acreedor_id == current_user.id || @debt.deudor_id == current_user.id) ? true : false
    if !approved
      # Perdon lo feo
      respond_to do |format|
        msg = 'You tried to create a debt/loan for others'
        format.html { redirect_to(@debt, notice: msg) }
        format.json do
          render(:index, status: :unṕrocessable_entity, location: @debt)
        end
      end
    else
      respond_to do |format|
        if @debt.save
          msg = 'Debt was successfully created.'
          format.html { redirect_to(@debt, notice: msg) }
          format.json { render(:index, status: :created, location: @debt) }
        else
          format.html { render(:new) }
          format.json do
            render(json: @debt.errors,
                   status: :unprocessable_entity)
          end
        end
      end
    end
  end

  # PATCH/PUT /debts/1
  # PATCH/PUT /debts/1.json
  def update
    respond_to do |format|
      if @debt.update(debt_params)
        msg = 'Debt was successfully updated.'
        format.html { redirect_to(@debt, notice: msg) }
        format.json { render(:show, status: :ok, location: @debt) }
      else
        format.html { render(:edit) }
        format.json do
          render(json: @debt.errors, status: :unprocessable_entity)
        end
      end
    end
  end

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @debt.destroy
    respond_to do |format|
      msg = 'Debt was successfully destroyed.'
      format.html { redirect_to(debts_url, notice: msg) }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_debt
    @debt = Debt.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def debt_params
    params.require(:debt).permit(:interest, :amount, :currency,
                                 :acreedor_id, :acreedor_type,
                                 :deudor_id, :deudor_type)
  end
end
