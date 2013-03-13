Feature: Users can search for a cigar

  @vcr
  Scenario: Stores near a user
    Given I am in Albuquerque
    When I list stores near me
    Then "Monte's Cigars, Tobacco And Gifts" should be closer than "Rio Rancho Cigars"
