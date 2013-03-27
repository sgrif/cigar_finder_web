@javascript @vcr
Feature: Adding a cigar
  Scenario: Navigating to the cigar form
    When I visit the home page
    And I click on "Add a Cigar"

    Then I should be at the add cigar form

  Scenario: Dropdown is populated with nearby stores
    When I visit the add cigar form from "Albuquerque"

    Then selected store should be "Monte's Cigars, Tobacco And Gifts"
    And the store list should contain "Stag Tobacconist"

  Scenario: Cigar box autocompletes
    Given somebody has searched for "Illusione Mk Ultra"

    When I visit the add cigar form from "Albuquerque"
    And I fill in the cigar input with "I"

    Then I should see an autocomplete box with the following:
      | Illusione Mk Ultra |

  Scenario: Users can report a cigar as carried
    Given I am in Albuquerque
    When I report that "Monte's Cigars, Tobacco And Gifts" carries "Tatuaje 7th Reserva"
    Then the page should show it is carried by "Monte's Cigars, Tobacco And Gifts"

  Scenario: Users can report a cigar as not carried
    Given I am in Albuquerque
    When I report that "Stag Tobacconist" does not carry "Illusione Mk Ultra"
    Then the page should show it is not carried by "Stag Tobacconist"
