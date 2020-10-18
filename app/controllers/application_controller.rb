# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate

  attr_reader :current_user

  def authenticate
    user = User.find_by(authentication_token: auth_header)

    if auth_header.present? && user.present?
      @current_user = user
    else
      head 401
    end
  end

  private

  def auth_header
    request.headers['Authorization']
  end
end
