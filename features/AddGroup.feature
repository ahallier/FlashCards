Feature: Allow FlashCards users to add a new group

Background:
  Given I am on the new group page 

  Scenario: Add a new group
    When I have set title to "Spagett", public to "Yes"
    And I have clicked button "Save Changes"
    And I am on the group page
    Then The group with title "Spagett" should be in the groups table
