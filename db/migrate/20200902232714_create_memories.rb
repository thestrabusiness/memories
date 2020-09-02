# frozen_string_literal: true

class CreateMemories < ActiveRecord::Migration[6.0]
  def change
    create_table :memories do |t|
      t.text :description
      t.timestamps null: false
    end
  end
end
