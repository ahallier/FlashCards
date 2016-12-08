Feature: Allow FlashCards user to sort decks on users page.

Background:
  Given user exists with email "agieg", password "spagett", session token, "abcde"
  And I have logged in as user with email "agieg" and password "spagett"
  And the following decks have been added to FlashCards:
  |id| title                 | score | public | user_id |
  |1 | ADeck                 | 0     | true   |   1     |
  |2 | BDeck                 | 0     | true   |   1     |
  And I am on the FlashCards user page 

  Scenario: Sort decks by title
    When I have clicked the Title header
    Then The deck with title "ADeck" should appear before "BDeck"