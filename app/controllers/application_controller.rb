# frozen_string_literal: true

# Application-wide controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end
