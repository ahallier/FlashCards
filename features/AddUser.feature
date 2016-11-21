Feature: Allow User to create an account

Background:
    Given I am on the New User page 
  
  Scenario: Create a User
      When I have set email to "ryan@email.com"
      And I have set password to "password"
      And I have clicked button "Create Account"
      Then The user with email "ryan@email.com", password "password" should be in the cards table
