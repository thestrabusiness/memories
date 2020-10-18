# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    skip_before_action :authenticate

    def create
      user = User.new(user_params)

      if user.save
        # send the sms
        head :created
      else
        render json: user.errors, status: :unprocessible_entity
      end
    end
  end
end
