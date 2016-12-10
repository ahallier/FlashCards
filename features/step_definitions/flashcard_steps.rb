Given /^I am on the FlashCards home page$/ do
  visit decks_path
 end
 
 Given /^I am on the FlashCards user page$/ do
  visit users_path
  page.should have_content("User Page")
 end
 
 Given /^I am on the new deck page$/ do
   visit new_deck_path
 end
 
 Given /^I am on the new group page$/ do
   visit new_group_path
 end
 
 Given /^I am on the group page$/ do
   visit groups_path
 end
 Given /^I am viewing card with id "(.*?)"$/ do |id|
    page.execute_script("PC.currentCard = '#{id}'"); 
 end
 
 Given /^I am on the practice cards page for deck 1$/ do
     visit card_display_path(1)
 end
 
 When /^I have set title to "(.*?)", public to "(.*?)"$/ do |title, pub|
   fill_in('Title', :with => title)
   select "Yes", :from => "public_select"
 end
 
 #And /^I have logged in as user with email "(.*?)" and password "(.*?)"$/ do |email, password|
 #   visit login_path
 #   fill_in('Email', :with => email)
 #   fill_in('Password', :with => password)
 #   click_button('login_submit')
 #end
 
 When /^I have clicked next$/ do
        click_button('Next')
 end
 
  When /^I have clicked cat$/ do
      sleep 2
      puts page.html
    find('.card-word').click
 end
 
 Then /^The group with title "(.*?)" should be in the groups table$/ do |title|
     visit groups_path
     find(:xpath, "//table/tbody/tr[.//td[contains('#{title}')]]")
     #page.should have_content(title)
 end
 
 Then /^definition should contain retractile$/ do
    page.should have_content('retractile')
 end
  
 Then /^I should see join group "(.*?)" success message on group page$/ do |title|
     page.should have_content("joined #{title}")
 end
 
 Then /^The group with title "(.*?)" should be in user group table$/ do |title|
    visit users_path
    find(:xpath, "//table/tbody/tr[.//td[contains('#{title}')]]")
 end
 
 Given /^The current user logs out.$/ do
    visit decks_path
    click_button("logout")
 end
 
 Given /^I am on the add deck to group page for group id "(.*?")$/ do |group_id|
     visit add_deck_to_group_path(group_id)
 end
 
 Given /^I am on the add user to group page for group id "(.*?")$/ do |group_id|
     visit add_user_to_group_path(group_id)
 end
 
 Given /^I am on the edit deck page for deck with title "(.*?)"$/ do |title|
   deck = Deck.find_by title: title
   visit edit_deck_path(id: deck.id)
 
 
 end
 
 Given /^I am on the group page for group id "(.*?")$/ do |group_id|
     visit group_display_path(group_id.to_i)
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

When /^I have clicked on the card$/ do
   click_link('#flip') 
end

When /^I have clicked button "(.*?)"$/ do |button_name|
     click_button(button_name)
end

When /^I have clicked the Title header$/ do
    click_on('Title')
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
Given /the following users have been added to FlashCards:/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end
Given /the following cards have been added to FlashCards:/ do |cards_table|
  cards_table.hashes.each do |card|
    Card.create!(card)
  end
end

Given /^user exists with email "(.*?)", password "(.*?)", session token, "(.*?)"$/ do |email, password, st|
    user_params = {
        :email => email,
        :password => password,
        :session_token => st
    }
    User.create!(user_params)
end


Given /^the deck with id "(.*?)" is in the group with id "(.*?)"$/ do |did, gid|
    d = Deck.find_by_id(did)
    g = Group.find_by_id(gid)
    g.decks << d
    g.save
end

Given /^user with email "(.*?)" is in group with id "(.*?)"$/ do |email, gid|
    g = Group.find_by_id(gid)
    u = User.find_by_email(email)
    g.users << u
    g.save
end

When /^I have clicked the delete button for deck with id "(.*?)"$/ do |did|
      find("#delete_deck_from_group_#{did}").click
end

When /^I have clicked the link to join group with title "(.*?)"$/ do |title|
      find(:xpath, "//tr[contains(.,'#{title}')]/td/a", :text => 'Join').click
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
  
  Then /^The deck with title "(.*?)" should appear before "(.*?)"$/ do |d1, d2|
    titles = all(:css, '#decks td:nth-child(1)').map {|x| x.text}
    expect(titles.find_index(d1) < titles.find_index(d2)).to be true

  end
  
  Then /^The deck with title "(.*?)" should be in group with id "(.*?)"$/ do |deck_title, group_id|
      visit group_display_path(group_id)
      page.should have_content(deck_title)
  end
  
  Then /^the deck with title "(.*?)" should not appear on the groups page for group with id "(.*?)"$/ do |deck_title, group_id|
      visit group_display_path(group_id)
      page.should_not have_content(deck_title)
  end

Given /^a valid user$/ do
  @user = User.create!({
             :email => "rkuemmel@hotmail.com",
             :password => "password",
           })
end

Given /^I have logged in as user with email "(.*?)" and password "(.*?)"$/ do |email, password|
     visit login_path
     fill_in 'Email', :with => email
     fill_in 'Password', :with => password
    click_button 'Login to my account'
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
 Then /^I should see the "(.*?)" of the card with id "(.*?)"$/ do |side,id|

       
 
 end


