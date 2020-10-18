# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    skip_before_action :authenticate

    def create
      user = User.find_or_create_by(phone_number: params[:phone_number])

      if user.persisted?
        TWILIO_CLIENT.messages.create(
          from: '+15866973461',
          to: user.phone_number,
          body: "Here's your Memories PIN: #{user.pin}"
        )
        head :created
      else
        render json: user.errors, status: :unprocessible_entity
      end
    end
  end
end
