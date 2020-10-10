# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    create_params = account_params
    create_params[:user_id] = current_user.id
    @account = Account.new(account_params)
    respond_to do |format|
      if @account.save
        msg = 'Account was successfully created.'
        format.html { redirect_to @account, notice: msg }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json do
          render json: @account.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        msg = 'Account was successfully updated.'
        format.html { redirect_to @account, notice: msg }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json do
          render json: @account.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      msg = 'Account was successfully destroyed.'
      format.html { redirect_to accounts_url, notice: msg }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:balance, :account_type, :currency, :quota)
  end
end
