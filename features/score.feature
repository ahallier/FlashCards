Background: cards are added to a deck
  Given the following cards have been added to FlashCards:
  | deck_id  | front  | back   |
  | 1        | Front1 | Back1  |
  | 1        | Front2 | Back2  |
  | 1        | Front3 | Back3  |
  And I am on the display cards page for deck_id "1" 
  And I am viewing the card with front "Front2"
  
Scenario: get a card correct
  When I have indicated that I got a card correct
  Then The score displayed on the page should increase