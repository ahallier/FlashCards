class ChangeDecksGroupsColNames < ActiveRecord::Migration
  def change
    rename_column :decks_groups, :decks_id, :deck_id
    rename_column :decks_groups, :groups_id, :group_id
  end
end
