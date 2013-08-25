@vcr
Feature: Missing information
  Scenario: Finding cigar without information at a store
    Given I am in Albuquerque
    And somebody has searched for "Tatuaje 7th Reserva"
    When I ask what information we need for "Monte's Cigars, Tobacco And Gifts"
    Then the cigar I am given should be "Tatuaje 7th Reserva"

  Scenario: Includes store information
    Given I am in Albuquerque
    And somebody has searched for "Any Cigar"
    When I ask what information we need for "Monte's Cigars, Tobacco And Gifts"
    Then the response should include the information for "Monte's Cigars, Tobacco And Gifts"

  Scenario: Most popular cigar is returned
    Given I am in Albuquerque
    And 2 people have searched for "Illusione Mk"
    And somebody has searched for "Tatuaje 7th Reserva"
    When I ask what information we need for "Stag Tobacconist"
    Then the cigar I am given should be "Illusione Mk"

  Scenario: Fallback to oldest information
    Given I am in Albuquerque
    And "Monte's Cigars, Tobacco And Gifts" was reported to carry "Tatuaje" yesterday
    And "Monte's Cigars, Tobacco And Gifts" carries "Illusione"
    When I ask what information we need for "Monte's Cigars, Tobacco And Gifts"
    Then the cigar I am given should be "Tatuaje"
