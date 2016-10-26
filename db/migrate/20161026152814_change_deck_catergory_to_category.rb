class ChangeDeckCatergoryToCategory < ActiveRecord::Migration
  def change
     rename_column :decks, :catergory, :category
  end
end
