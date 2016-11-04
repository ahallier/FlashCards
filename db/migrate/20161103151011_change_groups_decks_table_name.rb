class ChangeGroupsDecksTableName < ActiveRecord::Migration
  def change
    rename_table :groups_decks, :decks_groups
  end
end
