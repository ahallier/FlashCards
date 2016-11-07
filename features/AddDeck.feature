Feature: Allow FlashCards users to add a new deck

Background:
  Given I am on the new deck page 

  Scenario: Add a new deck
    When I have set title to "Spagett", category "Spagett Films"
    And I have clicked button "Save Changes"
    Then The deck with title "Spagett", category "Spagett Films" should be in the decks table
