# frozen_string_literal: true

# Application-wide controller
class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
end
