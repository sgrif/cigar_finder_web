@vcr
Feature: Missing information
  Scenario: Finding cigar without information at a store
    Given I am in Albuquerque
    And somebody has searched for "Tatuaje 7th Reserva"
    When I ask what information we need for "Monte's Cigars, Tobacco And Gifts"
    Then the cigar I am given should be "Tatuaje 7th Reserva"

  Scenario: Most popular cigar is returned
    Given I am in Albuquerque
    And 2 people have searched for "Illusione Mk"
    And somebody has searched for "Tatuaje 7th Reserva"
    When I ask what information we need for "Stag Tobacconist"
    Then the cigar I am given should be "Illusione Mk"
