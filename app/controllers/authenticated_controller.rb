# frozen_string_literal: true

# Application-wide controller
class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
end
