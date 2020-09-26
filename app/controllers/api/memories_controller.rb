module Api
  class MemoriesController < ApplicationController
    def index
      memories = Memory.all.map { |memory| serialized_memory(memory) }
      render json: memories
    end

    def show
      memory = Memory.find(params[:id])
      render json: serialized_memory(memory)
    end

    def create
      memory = Memory.create(memory_params)
      if memory.valid?
        render json: serialized_memory(memory)
      else
        render json: memory.errors
      end
    end

    private

    def memory_params
      params.require(:memory).permit(:description, images: [])
    end

    def serialized_memory(memory)
      images = memory.images.map {|image| url_for(image)}
      memory_without_images = memory.as_json
      memory_without_images.merge({images: images})
    end
  end
end

