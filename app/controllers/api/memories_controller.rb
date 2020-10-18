# frozen_string_literal: true

module Api
  class MemoriesController < ApplicationController
    def index
      memories = current_user.memories.map { |memory| serialized_memory(memory) }
      render json: memories
    end

    def show
      memory = current_user.memories.find(params[:id])
      render json: serialized_memory(memory)
    end

    def create
      memory = current_user.memories.create(memory_params)
      if memory.valid?
        render json: serialized_memory(memory)
      else
        render json: memory.errors
      end
    end

    private

    def memory_params
      params.require(:memory).permit(:description, images: [:data])
    end

    def serialized_memory(memory)
      images = memory.images.map { |image| url_for(image) }
      memory_without_images = memory.as_json
      memory_without_images.merge({ images: images })
    end
  end
end
