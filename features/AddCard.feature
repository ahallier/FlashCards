Feature: Allow FlashCards users to edit a card

Background:
    Given the following cards have been added to FlashCards:
  |id|front|back|
  | 1                 | front | back |
  | 2                 | front | back   |
  And I am on the edit card page for card with deck_id "1"
  
  Scenario: Edit a card
      When I have set front to "front1", back "back1"
      And I have clicked button "Update Card Info"
      Then The deck with front "front1", category "back1" should be in the cards table

