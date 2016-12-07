Feature: Allow FlashCards users to add a new user to group

Background:
  Given the following groups have been added to FlashCards:
  |id| title                 | public |
  |1 | TestGroup             | true   |
  And the following users have been added to FlashCards:
  | email                 | password|
  | a@gmail.com           | password|
   
  And user exists with email "agieg", password "spagett", session token, "abcde"
  And I have logged in as user with email "agieg" and password "spagett"
  And I am on the add user to group page for group id "1" 

  Scenario: Add a user to a group
    When I have checked box with id "#users_1"
    And I have clicked button "Add Users to Group"
    And I have logged in as user with email "a@gmail.com" and password "password"
    And I have visited the user home page
    Then The the group with title "TestGroup" should be in group table 