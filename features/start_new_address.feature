Feature: first weather query

  As a user
  So I can check the weather
  I want to start a new game

Scenario: I start a new search

  Given I am on the new page
  Then I should see "Weather, wherever"
  When I enter "2833 Bancroft Steps"
  Then I should be on the show page
  
Scenario: I try an empty search
  
  Given I am on the new page
  Then I should see "Weather, wherever"
  When I enter ""
  Then I should be on the new page
