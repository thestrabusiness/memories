# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    skip_before_action :authenticate

    def create
      user = User.find_or_create_by(user_params)

      if user.persisted?
        TWILIO_CLIENT.messages.create(
          from: '+15866973461',
          to: user.phone_number,
          body: "Here's your Memories PIN: #{user.pin}"
        )
        head :created
      else
        head :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:phone_number)
    end
  end
end
