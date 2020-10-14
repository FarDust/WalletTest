# frozen_string_literal: true

# Application-wide controller
class ApplicationController < ActionController::Base
  before_action :set_raven_context
  before_action :authenticate_user!

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
