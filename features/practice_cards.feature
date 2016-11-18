Background: cards are added to a deck
  Given the following cards have been added to FlashCards:
  | deck_id  | front  | back   |
  | 1        | Front1 | Back1  |
  | 1        | Front2 | Back2  |
  | 1        | Front3 | Back3  |
  And I am on the display cards page for deck_id "1" 
  And I am viewing the card with front "Front2"

Scenario: switch to next card
  When I click on the next button
  Then I should see the front of the card with front "Front3"
Scenario: switch to previous card
  When I click on the last button
  Then I should see the front of the card with front "Front1"
Scenario: flip over a card
  When I click on the card in the top of the screen
  Then I should see the back of the card with back "Back2"
  
  