# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :phone_number, null: false, index: true
      t.string :pin, null: false, index: true
      t.string :authentication_token, null: false, index: true

      t.timestamps null: false
    end

    add_reference :memories, :user, null: false, index: true, foreign_key: true
  end
end
