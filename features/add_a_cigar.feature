@javascript @vcr
Feature: Adding a cigar

  Scenario: Dropdown is populated with nearby stores
    Given I am in Albuquerque

    When I visit the home page
    And I open the add cigar form

    Then selected store should be "Monte's Cigars, Tobacco And Gifts"
    And the store list should contain "Stag Tobacconist"
