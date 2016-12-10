Feature: Allow FlashCards users to edit a deck

Background:
 Given I have logged in as user with email "agieg" and password "agieg"
 And user exists with email "agieg", password "agieg", id, "1"
 And the following decks have been added to FlashCards:
  | title                 | score | public | user_id |
  | Test1                 | 5     | true   | 1       |
  And I am on the edit deck page for deck with title "Test1"
  
  Scenario: Edit a deck
      When I have set title to "Spagett", category "Spagett Films"
      And I have clicked button "Update Deck Info"
      Then The deck with title "Spagett", category "Spagett Films" should be in the decks table

