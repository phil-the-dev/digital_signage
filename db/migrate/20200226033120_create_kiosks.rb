class CreateKiosks < ActiveRecord::Migration[6.0]
  def change
    create_table :kiosks do |t|
      t.string :code
      t.text :playable_id
      t.string :name

      t.timestamps
    end
  end
end
