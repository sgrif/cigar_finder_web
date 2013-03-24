@javascript @vcr
Feature: Cigar Search Form
  Scenario: The intro search form autocompletes
    Given somebody has searched for "Tatuaje 7th Reserva"

    When I visit the home page
    And I open the search box
    And I fill in the search box with "T"

    Then I should see an autocomplete box with the following:
      | Tatuaje 7th Reserva |

  Scenario: Intro search form does not have duplicates
    Given somebody has searched for "Tatuaje 7th Reserva"
    And somebody has searched for "Tatuaje Cojonu 2012 Broadleaf"
    And somebody else has searched for "Tatuaje 7th Reserva"

    When I visit the home page
    And I open the search box
    And I fill in the search box with "T"

    Then I should see an autocomplete box with the following:
      | Tatuaje 7th Reserva           |
      | Tatuaje Cojonu 2012 Broadleaf |

  Scenario: Search page search form autocompletes
    Given somebody has searched for "Illusione Mk Ultra"

    When I visit the search page for "La Dueña"
    And I fill in the search box with "I"

    Then I should see an autocomplete box with the following:
      | Illusione Mk Ultra |

  Scenario: Search box automatically adds new searches
    Given somebody has searched for "Tatuaje 7th Reserva"

    When I visit the search page for "Tatuaje Cojonu 2012 Broadleaf"
    And I fill in the search box with "T"

    Then I should see an autocomplete box with the following:
      | Tatuaje 7th Reserva           |
      | Tatuaje Cojonu 2012 Broadleaf |

  Scenario: Cigars added by browser does not produce duplicates
    Given somebody has searched for "Tatuaje 7th Reserva"

    When I visit the search page for "Tatuaje 7th Reserva"
    And I fill in the search box with "T"

    Then I should see an autocomplete box with the following:
      | Tatuaje 7th Reserva |

