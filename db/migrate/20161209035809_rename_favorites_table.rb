class RenameFavoritesTable < ActiveRecord::Migration
  def change
    rename_table :users_fav_decks, :favorites
  end
end
