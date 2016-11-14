class ChangeUserDecksTableName < ActiveRecord::Migration
  def change
    rename_table :decks_users, :users_fav_decks
  end
end
