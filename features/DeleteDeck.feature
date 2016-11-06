Feature: Allow FlashCards user to delete a deck

Scenario:  Delete a deck (Declarative)
  When I have deleted a deck with title "Test1"
  And I am on the FlashCards home page  
  Then I should not see a deck list entry with title "Test1"
