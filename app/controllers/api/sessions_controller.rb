# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    skip_before_action :authenticate

    def create
      user = User.find_by(phone_number: params[:phone_number], pin: params[:pin])

      if user.present?
        user.set_authentication_token
        user.save!
        render json: user, status: :ok
      else
        head :unauthorized
      end
    end
  end
end
