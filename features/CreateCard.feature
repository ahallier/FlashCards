Feature: Allow FlashCards user to add a card to a deck

Background: movies have been added to FlashCards

  Given the following decks have been added to FlashCards:
  |id| title                 | score | public |
  |1 | Test1                 | 5     | true   |

  And  I am on the FlashCards home page

Scenario:  CreateCard (Declarative)
  When I have added a card with front "testfront" and back "testback" to deck "1"
  And I am on the display cards page for deck "1"   
  Then I should see a card with front "testfront" and back "testback"