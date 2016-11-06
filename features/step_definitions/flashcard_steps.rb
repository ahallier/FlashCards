# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the FlashCards home page$/ do
  visit decks_path
 end

When /^I have deleted a deck with title "(.*?)"/ do |deckTitle|
  page.all(:xpath, '//table/tr[.//td[contains("#{deckTitle}")]]').each do |tr|
    find("#btn_delete").click
  end
  find("#btn_delete").click
end
 
 Given /the following decks have been added to FlashCards:/ do |decks_table|
  decks_table.hashes.each do |deck|
    Deck.create!(deck)
  end
end
  
  Then /^(?:|I )should notsee "([^"]*)"$/ do |text|
    page.should have_no_content(text)
  end


