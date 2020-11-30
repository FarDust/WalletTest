# frozen_string_literal: true

# Application-wide controller
class ApplicationController < ActionController::Base
  before_action :set_raven_context
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
