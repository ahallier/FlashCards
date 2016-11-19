Given /^I am on the FlashCards home page$/ do
  visit decks_path
 end
 
 Given /^I am on the new deck page$/ do
   visit new_deck_path
 end
 
 Given /^I am on the add deck to group page for group id "(.*?")$/ do |group_id|
     visit add_deck_to_group_path(group_id)
 end
 
 Given /^I am on the edit deck page for deck with title "(.*?)"$/ do |title|
   deck = Deck.find_by title: title
   visit edit_deck_path(id: deck.id)
 end
 Given /^I am on the display deck page for deck with title "(.*?)"$/ do |title|
   deck = Deck.find_by title: title
   visit edit_deck_path(id: deck.id)
 end
 Given /^I am on the display cards page for deck "(.*?)"$/ do |deck|
    visit '/cards/'+deck+'/display' 
 end
 When /^I have set title to "(.*?)", category "(.*?)"$/ do |title, cat|
   fill_in('Title', :with => title)
   fill_in('Category', :with => cat)
 end
When /^I have deleted a deck with title "(.*?)"/ do |deckTitle|
  page.all(:xpath, '//table/tr[.//td[contains("#{deckTitle}")]]').each do |tr|
    find("#btn_delete").click
  end
  find("#btn_delete").click
end

When /^I have clicked button "(.*?)"$/ do |button_name|
     click_button(button_name)
end

When /^I have checked box with id "(.*?)"$/ do |id|
    find(:css, id).set(true)
end

When /^I have added a card with front "(.*?)" and back "(.*?)" to deck "(.*?)"$/ do |front,back,deck|
  visit '/decks/'+deck+'/edit/writecard'
  fill_in 'Front', :with => front
  fill_in 'Back', :with => back

  click_button 'Save Changes'     
 end   
 Given /the following decks have been added to FlashCards:/ do |decks_table|
  decks_table.hashes.each do |deck|
    Deck.create!(deck)
  end
end

 Given /the following groups have been added to FlashCards:/ do |groups_table|
  groups_table.hashes.each do |group|
    Group.create!(group)
  end
end

  Then /^The deck with title "(.*?)", category "(.*?)" should be in the decks table$/ do |title, cat|
      visit decks_path
      page.should have_content(title)
      page.should have_content(cat)
  end
  

  
  Then /^(?:|I )should notsee "([^"]*)"$/ do |text|
    page.should have_no_content(text)
  end
  Then /^I should see a card with front "(.*?)" and back "(.*?)"$/ do |front, back| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(front) && tr.has_content?(back)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end 


