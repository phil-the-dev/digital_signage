class CreateEpisodeSegments < ActiveRecord::Migration[6.0]
  def change
    create_table :episode_segments do |t|
      t.references :episode, null: false, foreign_key: true
      t.references :segment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
