@javascript @vcr
Feature: Adding a cigar
  Scenario: Users can report a cigar as carried
    Given I am in Albuquerque
    When I report that "Monte's Cigars, Tobacco And Gifts" carries "Tatuaje 7th Reserva"
    Then the page should show it is carried by "Monte's Cigars, Tobacco And Gifts"

  Scenario: Users can report a cigar as not carried
    Given I am in Albuquerque
    When I report that "Stag Tobacconist" does not carry "Illusione Mk Ultra"
    Then the page should show it is not carried by "Stag Tobacconist"

  Scenario: Users can report incorrect data
    Given I am in Albuquerque
    And "Rio Rancho Cigars" carries "Tatuaje 7th Reserva"

    When I visit the search page for "Tatuaje 7th Reserva"
    When I report that the data for "Rio Rancho Cigars" is incorrect

    Then the page should show it is not carried by "Rio Rancho Cigars"
