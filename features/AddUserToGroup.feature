Feature: Allow FlashCards users to add a new user to group

Background:
  Given the following groups have been added to FlashCards:
  |id| title                 | public | owner_id|
  |1 | TestGroup             | false   | 3 |
  Given the following users have been added to FlashCards:
  |id| email                 | password|
  |2 | a@gmail.com           | password|
   
  And user exists with email "agieg", password "spagett", session token, "abcde"
  And I have logged in as user with email "agieg" and password "spagett"
  And I am on the add user to group page for group id "1" 

  Scenario: Add a user to a group
    When I have checked box with id "#users_2"
    And I have clicked button "Add Users to Group"
    And The current user logs out.
    And I have logged in as user with email "a@gmail.com" and password "password"
    And I am on the FlashCards user page
    Then The group with title "TestGroup" should be in user group table 