# frozen_string_literal: false

class DashboardController < ApplicationController
  helper DashboardHelper
  helper MovementsHelper
  include AccountsHelper
  include MovementsHelper

  def index
    @accounts = get_accounts(current_user)
    @relevant_movements = get_relevant_movements(current_user)
  end

  def show
    @account = Account.find(params[:id])
  end
end
