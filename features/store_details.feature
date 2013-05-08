@vcr
Feature: Store details are loaded
  Scenario: Phone number is loaded
    Given I am in Albuquerque
    When I list stores near me
    Then I should see "(505) 881-7999" as the phone number for "Monte's Cigars, Tobacco And Gifts"
