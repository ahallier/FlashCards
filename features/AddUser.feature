Feature: Allow User to create an account

Background:
    Given I am on the create new user page
  
  Scenario: Create a User
      When I have set email to "ryan@email.com", password "password"
      And I have logged in as user with email "ryan@email.com" and password "password"
      And I am on the FlashCards home page
      Then the user with email "ryan@email.com" should be in the welcome message
