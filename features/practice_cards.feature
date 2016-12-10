#This feature was having issues because the pages they test use javascript 
Feature: Allow FlashCards user to practice a deck

#Background: cards are added to a deck
#  Given the following decks have been added to FlashCards:
#  |id|
#  |1 |
#  And the following cards have been added to FlashCards:
#  |id| deck_id  | front  | back   |
#  |1 | 1        | Front1 | Back1  |
#  |2 | 1        | Front2 | Back2  |
#  |3 | 1        | Front3 | Back3  |
#  And I am on the display cards page for deck "1" 
#  And I am viewing card with id "2"
  

#Scenario: switch to forward through cards
#  When I have clicked button "Next"
#  Then I should see the "front" of the card with id "3"
#Scenario: switch to previous card
# When I have clicked button "Next"
# Then I should see the "front" of the card with id "1"
#Scenario: flip over a card
#  When I click on the card in the top of the screen
#  Then I should see the "front" of the card with id "2"