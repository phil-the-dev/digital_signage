# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :name
      t.string :token
      t.boolean :deleted, null: false, default: true
      t.references :auth_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
