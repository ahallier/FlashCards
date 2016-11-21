Feature: Allow FlashCards users to log in

Background:
    Given the following user exists:
  | email                 | passsword
  | ryan@email.com                 | passsword     
  And I am on the login page 
  
  Scenario: Login
      When I have set email to "ryan@email.com", password "passsword"
      And I have clicked button "Login to my account"
      Then The user with email "ryan@email.com" should be logged in

