Feature: Delete a user

  Background: Existing user
    Given user profile data
      | email              | country | street      | postalCode |
      | john.doe@gmail.com | England | Road Avenue | 29145      |
    When I send a request to create a user

  Scenario: I can delete a user
    When I send a request to delete my user
    Then I cannot see my user ID in the first page of the users list

  Scenario: I cannot delete a user that does not exist
    When I send a request to delete the user "2cdc8ab1-6d50-49cc-ba14-54e4ac7ec231"
    Then I receive an error response "Not Found" with status code 404 and a correlation ID

  Scenario: I cannot delete a user with an invalid id
    When I send a request to delete the user "not-a-uuid"
    Then I receive an error response "Bad Request" with status code 400 and a correlation ID
    And the first sub-error points to "/id"
