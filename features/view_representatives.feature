Feature: display list of representatives of a specific county

  As a US citizen
  So that I can see the representatives for different US counties
  I want to see the representatives when I click on a county

Scenario: Select Santa Clara County
  Given I select 'California' on the map
  Then I select 'Santa Clara' county
  Then I should see the list of reps for 'Santa Clara'
