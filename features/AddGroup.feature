Feature: Allow FlashCards users to add a new group

Background:
  Given I am on the new group page 

  Scenario: Add a new group
    When I have set title to "Spagett", public to "Yes"
    And I have clicked button "Save Changes"
    Then The group with title "Spagett" should be in the groups table
