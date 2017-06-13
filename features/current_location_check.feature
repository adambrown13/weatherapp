Feature: current weather pulled up

  As a user
  So I can check the weather
  I want to make sure my query went through

Scenario: I start a new search

  Given I am on the new page
  Then I should see "Weather, wherever"
  When I enter "2833 Bancroft Steps"
  Then I should be on the show page
  And I should see "Current Weather: Clear"
  And I should see "Temperature at Location: 71.83"
  And I should see "Chance of Rain: 0 %"