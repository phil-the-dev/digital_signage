class CreatePlaylistPlayables < ActiveRecord::Migration[6.0]
  def change
    create_table :playlist_playables do |t|
      t.references :playlist, null: false, foreign_key: true
      t.string :playable_id
      t.integer :order_number

      t.timestamps
    end
  end
end
