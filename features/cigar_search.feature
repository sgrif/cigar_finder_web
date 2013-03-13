@vcr
Feature: Users can search for a cigar

  Scenario: Stores near a user
    Given I am in Albuquerque
    When I list stores near me
    Then "Monte's Cigars, Tobacco And Gifts" should be closer than "Rio Rancho Cigars"

  Scenario: Only nearby stores within driving distance are listed

  Scenario: Store carries a cigar
    Given "Monte's Cigars, Tobacco And Gifts" carries "Larry's Bundle"
    When I search for "Larry's Bundle" in Albuquerque
    Then I should see it is carried by "Monte's Cigars, Tobacco And Gifts"

  Scenario: Two stores with same name

  Scenario: Store does not carry a cigar
    Given "Stag Tobacconist" carries "Tatuaje 7th Reserva"
    And "Rio Rancho Cigars" does not carry "Tatuaje 7th Reserva"
    When I search for "Tatuaje 7th Reserva" in Albuquerque
    Then I should see it is carried by "Stag Tobacconist"
    And I should see it is not carried by "Rio Rancho Cigars"
