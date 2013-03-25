@javascript @vcr
Feature: Adding a cigar

  Scenario: Dropdown is populated with nearby stores
    Given I am in Albuquerque

    When I visit the home page
    And I open the add cigar form

    Then selected store should be "Monte's Cigars, Tobacco And Gifts"
    And the store list should contain "Stag Tobacconist"

  Scenario: Cigar box autocompletes
    Given somebody has searched for "Illusione Mk Ultra"

    When I visit the home page
    And I open the add cigar form
    And I fill in the cigar input with "I"

    Then I should see an autocomplete box with the following:
      | Illusione Mk Ultra |
