Feature: Search

  Scenario: Search test
    Given I am on search page
    When I type in text to search

  Scenario: New search
    Given I am initialize a new search
    When I type new text
