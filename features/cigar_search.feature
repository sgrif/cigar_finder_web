Feature: Users can search for a cigar

  @vcr
  Scenario: Stores near a user
    Given I am in Albuquerque
    When I list stores near me
    Then "Monte's Cigars, Tobacco And Gifts" should be closer than "Rio Rancho Cigars"

  @vcr
  Scenario: Store carries a cigar
    Given "Monte's Cigars, Tobacco And Gifts" carries "Larry's Bundle"
    When I search for "Larry's Bundle" in Albuquerque
    Then I should see it is carried by "Monte's Cigars, Tobacco And Gifts"
