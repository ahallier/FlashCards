Feature: Allow FlashCards users to add a new group

Background:
  
  Given user exists with email "agieg", password "spagett", session token, "abcde"
  And I have logged in as user with email "agieg" and password "spagett"
  And I am on the new group page 
  
  Scenario: Add a new group
    When I have set title to "Spagett", public to "Yes" in add group
    And I have clicked button "Save Changes"
    And I am on the group page
    Then The group with title "Spagett" should be in the groups table
