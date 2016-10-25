class CreateFlashcards < ActiveRecord::Migration
  def change
    create_table :decks do |d|
      d.string :title
      d.integer :score
      d.text :catergory
      d.datetime :create_date
      d.integer :public
      d.timestamps
    end
    create_table :cards do |c|
      c.belongs_to :deck, index: true
      c.text :front
      c.text :back
      c.timestamps
    end
    create_table :users do |u|
      u.text :email
      u.text :password
      u.timestamps
    end
    create_table :groups do |g|
      g.text :title
      g.timestamps
    end
    create_table :users_decks, id: false do |ud|
      ud.belongs_to :users, index: true
      ud.belongs_to :decks, index: true
    end
    create_table :groups_decks, id: false do |gd|
      gd.belongs_to :groups, index: true
      gd.belongs_to :decks, index: true
    end
    create_table :users_groups, id: false do |ug|
      ug.belongs_to :users, index: true
      ug.belongs_to :groups, index: true
    end
  end
end
