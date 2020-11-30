# frozen_string_literal: true

class UsersController < AuthenticatedController
  before_action :set_user, only: %i[enable destroy]

  def index
    @users = User.availables
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
        @user.disable
        msg = t('users.actions.destroy.success')
        format.html { redirect_to(users_path, notice: msg) }
        format.json { render(:show, status: :ok, location: @debt) }
      else
        msg = t('users.actions.destroy.failed')
        format.html { redirect_to(users_path, notice: msg) }
        format.json { render(:show, status: :ok, location: @debt) }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :enabled)
  end
end
