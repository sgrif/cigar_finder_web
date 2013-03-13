@vcr
Feature: Users can search for a cigar
  Scenario: Stores near a user
    Given I am in Albuquerque
    When I list stores near me
    Then "Monte's Cigars, Tobacco And Gifts" should be closer than "Rio Rancho Cigars"

  Scenario: Only nearby stores within driving distance are listed
    Given I am in Albuquerque
    When I list stores near me
    Then "Primo Cigar Company" should not be listed

  Scenario: Store carries a cigar
    Given I am in Albuquerque
    And "Monte's Cigars, Tobacco And Gifts" carries "Larry's Bundle"
    When I search for "Larry's Bundle"
    Then I should see it is carried by "Monte's Cigars, Tobacco And Gifts"

  Scenario: Stores can have the same name
    Given "La Casa del Habano" in "Vancouver" carries "Cohiba Siglo II"
    And "La Casa del Habano" in "Windsor" does not carry "Cohiba Siglo II"

    When I search for "Cohiba Siglo II" in "Vancouver"
    Then I should see it is carried by "La Casa del Habano"

    When I search for "Cohiba Siglo II" in "Windsor"
    Then I should see it is not carried by "La Casa del Habano"

    When I search for "Cohiba Siglo II" in "Montreal"
    Then I should see no answer for "La Casa del Habano"

  Scenario: Store does not carry a cigar
    Given I am in Albuquerque
    And "Stag Tobacconist" carries "Tatuaje 7th Reserva"
    And "Rio Rancho Cigars" does not carry "Tatuaje 7th Reserva"
    When I search for "Tatuaje 7th Reserva"
    Then I should see it is carried by "Stag Tobacconist"
    And I should see it is not carried by "Rio Rancho Cigars"

  Scenario: No information for store and cigar
    When I search for "Something Obscure" in "Albuquerque"
    Then I should see no answer for "Rio Rancho Cigars"
