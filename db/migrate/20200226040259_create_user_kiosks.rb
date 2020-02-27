class CreateUserKiosks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_kiosks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :kiosk, null: false, foreign_key: true

      t.timestamps
    end
  end
end
