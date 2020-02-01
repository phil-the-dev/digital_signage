class CreateSegments < ActiveRecord::Migration[6.0]
  def change
    create_table :segments do |t|
      t.string :video_url
      t.string :title

      t.timestamps
    end
  end
end
