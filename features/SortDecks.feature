Feature: Allow FlashCards user to sort decks by title

Background:
  Given the following decks have been added to FlashCards:
  |id| title                 | score | public |
  |1 | ADeck                 | 0     | true   |
  |2 | BDeck                 | 0     | true   |
  And I am on the FlashCards home page 

  Scenario: Sort decks by title
    When I have clicked the Title header
    Then The deck with title "ADeck" should appear before "BDeck"