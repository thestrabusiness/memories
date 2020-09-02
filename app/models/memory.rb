# frozen_string_literal: true

class Memory < ApplicationRecord
  has_many_attached :images

  validate :at_least_image_or_description?

  private

  def at_least_image_or_description?
    return if description.present? || images.present?

    errors.add(:required_fields, 'Must have at least a description or one image')
  end
end
