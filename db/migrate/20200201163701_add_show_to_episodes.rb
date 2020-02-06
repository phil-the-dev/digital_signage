class AddShowToEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_reference :episodes, :show, null: true, foreign_key: true
  end
end
