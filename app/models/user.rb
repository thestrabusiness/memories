# frozen_string_literal: true

class User < ApplicationRecord
  PIN_CHARS = ('1'..'9').to_a

  has_many :memories

  validates :phone_number, :pin, :authentication_token, presence: true
  validates :phone_number, uniqueness: true

  before_validation :set_authentication_token, if: :new_record?
  before_validation :set_pin, if: :new_record?

  def self.generate_pin
    4.times.map { PIN_CHARS.sample }.join
  end

  def set_authentication_token
    self.authentication_token = SecureRandom.hex
  end

  def set_pin
    self.pin = User.generate_pin
  end
end
