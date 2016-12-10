Feature: Allow FlashCards user to delete a deck

Background: decks have been added to FlashCards

  Given the following decks have been added to FlashCards:
  | title                 | score | public | owner_id
  | Test1                 | 5     | true   | 1
  And user exists with email "agieg", password "spagett", session token, "abcde"
  And I have logged in as user with email "agieg" and password "spagett"
  And I am on the FlashCards user page
  
  
Scenario:  Delete a deck (Declarative)
  When I have deleted a deck with title "Test1"
  And I am on the FlashCards user page  
  Then I should notsee "Test1"
