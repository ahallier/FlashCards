# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#movies = [{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'},
#    	  {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984'},
#    	  {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989'},
#      	  {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011'},
#      	  {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'},
#      	  {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001'},
#      	  {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968'},
#      	  {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004'},
#      	  {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'},
#      	  {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
#  	 ]

#movies.each do |movie|
#  Movie.create!(movie)
#end
    
# Deck Schema    
#t.string   "title"
#t.integer  "score"
#t.text     "category"
#t.integer  "public"
#t.datetime "created_at"
#t.datetime "updated_at"
#decks = [
#    {:title => 'Albert\'s Deck', :score => 3, :category => 'chinese', :public => true, :created_at => DateTime.now, :updated_at => DateTime.now},
#    {:title => 'MyDeck', :score => 0, :category => 'spanish', :public => false, :created_at => DateTime.now, :updated_at => DateTime.now}
#]

#decks.each do |deck|
#    Deck.create!(deck)
#end

#cards = [
#    {:deck_id => 2, :front => "frontTest", :back => "backTest"},
#    {:deck_id => 1, :front => "Albert", :back => "Albert"},
#    {:deck_id => 2, :front => "Lucas", :back => "Bombal"},
#    {:deck_id => 2, :front => "Sydney", :back => "Garcia"},
#    {:deck_id => 2, :front => "Ryan", :back => "Kuemmel"},
#    {:deck_id => 2, :front => "Andrea", :back => "Hallier"},
#    {:deck_id => 2, :front => "Albert", :back => "Geigrich"}
#]
#
#cards.each do |card|
#    Card.create!(card)
#end
#
#groups = [
#    {:title => "My Group", :created_at => DateTime.now, :updated_at => DateTime.now, :public => true},
#    {:title => "Your Group", :created_at => DateTime.now, :updated_at => DateTime.now, :public => false}
#]
#
#groups.each do |g|
#    Group.create!(g)
#end