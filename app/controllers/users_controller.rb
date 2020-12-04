# frozen_string_literal: true

class UsersController < AuthenticatedController
  before_action :set_user, only: %i[enable destroy]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def enable
    respond_to do |format|
      @user.update(enabled: !@user.enabled)
      msg = 'User was successfully updated.'
      format.html { redirect_to(users_path, notice: msg) }
      format.json { render(:show, status: :ok, location: @user) }
    end
  end

  def destroy
    respond_to do |format|
      if @user.can_be_destroyed?
        @user.destroy
        msg = t('users.actions.destroy.success')
        format.html { redirect_to(users_path, notice: msg) }
        format.json { head(:no_content) }
      else
        msg = t('users.actions.destroy.failed')
        format.html { redirect_to(users_path, notice: msg) }
        format.json { render(:show, status: :ok, location: @user) }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
