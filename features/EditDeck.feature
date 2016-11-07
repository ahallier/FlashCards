Feature: Allow FlashCards users to edit a deck

Background:
    Given the following decks have been added to FlashCards:
  | title                 | score | public |
  | Test1                 | 5     | true   |
  And I am on the edit deck page for deck with title "Test1"
  
  Scenario: Edit a deck
      When I have set title to "Spagett", category "Spagett Films"
      And I have clicked button "Update Deck Info"
      Then The deck with title "Spagett", category "Spagett Films" should be in the decks table

