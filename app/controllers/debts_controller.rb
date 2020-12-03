# frozen_string_literal: true

class DebtsController < AuthenticatedController
  before_action :set_debt, only: %i[show edit update destroy]

  # GET /debts
  # GET /debts.json
  def index
    @debts = Debt.all
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
    NaturalPerson.all.each do |i|
      print("PONER PERSONAS NATURALS", i.id)
    end
    print(debt_params)
    @debt = Debt.new(debt_params)
    print('Tipo de deudor', @debt.deudor_id, ' y tmbn ', @debt.deudor_type)
    respond_to do |format|
      if @debt.save
        msg = 'Debt was successfully created.'
        format.html { redirect_to(@debt, notice: msg) }
        format.json { render(:show, status: :created, location: @debt) }
      else
        format.html { render(:new) }
        format.json do
          render(json: @debt.errors,
                 status: :unprocessable_entity)
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
    params.require(:debt).permit(:interest, :amount,
                                 :acreedor_id, :acreedor_type,
                                 :deudor_id, :deudor_type)
  end
end
