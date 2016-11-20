Feature: Allow FlashCards user to join a public group

Background: groups have been added to FlashCards

  Given the following groups have been added to FlashCards:
  | title                 | public |
  | Test                  | true   |

  Given user exists with email "test@test.com", password "123", session token, "1234"
  Given I have logged in as user with email "test@test.com" and password "123"

  
  Given  I am on the group page

Scenario:  User joins a group
  When I have clicked the link to join group with title "Test"
  Then I should see join group "Test" success message on group page
