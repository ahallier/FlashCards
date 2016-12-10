Feature: Allow FlashCards user to delete a card

Background: movies have been added to FlashCards

  Given the following decks have been added to FlashCards:
  | title                 | score | public |
  | Test1                 | 5     | true   |

  And  I am on the FlashCards home page

Scenario:  Delete a card (Declarative)
  When I have deleted a deck with title "Test1"
  And I am on the FlashCards home page  
  Then I should notsee "Test1"
