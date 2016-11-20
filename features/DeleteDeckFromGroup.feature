Feature: Allow FlashCards users to delete a deck from a group

Background:
  Given the following groups have been added to FlashCards:
  |id| title                 | public |
  |1 | TestGroup             | true   |
  And the following decks have been added to FlashCards:
  |id| title                 | score | public |
  |1 | TestDeck              | 5     | true   |
  And user exists with email "agieg", password "spagett", session token, "abcde"
  And I have logged in as user with email "agieg" and password "spagett"
  And user with email "agieg" is in group with id "1"
  And the deck with id "1" is in the group with id "1"
  And I am on the group page for group id "1" 

  Scenario: Delete a deck from a group
    When I have clicked the delete button for deck with id "1"
    Then the deck with title "TestDeck" should not appear on the groups page for group with id "1"
    