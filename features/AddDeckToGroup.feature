Feature: Allow FlashCards users to add a new deck

Background:
  Given the following groups have been added to FlashCards:
  |id| title                 | public |
  |1 | TestGroup             | true   |
  And the following decks have been added to FlashCards:
  |id| title                 | score | public |
  |1 | TestDeck              | 5     | true   |
  And I am on the add deck to group page for group id "1" 

  Scenario: Add a deck to a group
    When I have checked box with id "#decks_1"
    And I have clicked button "Add Decks to Group"
    Then The deck with title "TestDeck" should be in group with id 1 