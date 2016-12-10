Feature: Allow FlashCards users to edit a card

Background:
    Given the following decks have been added to FlashCards:
  |id|title|category|
  | 1                 | Title | Category |
  And I am on the create card page for card with deck_id "1"
  
  Scenario: Add a card
      When I am adding a card with front "front1" and back "back1" to deck "1"
      And I have clicked button "Save Changes"
      Then The card with front "front1", back "back1" should be in the cards table for deck "1"

