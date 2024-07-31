*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Resource    ../Resources/Keywords.robot
Suite Setup    Create Object for Suite

*** Variables ***
${BASE_URL}    https://api.restful-api.dev/objects
${OBJECT_ID}   None

*** Test Cases ***
Smoke Test: Retrieve Objects
    [Documentation]    Quick test to verify the GET /objects endpoint
    Given the API is accessible
    When I send a GET request to retrieve objects
    Then the response status code should be 200
    And the first object should have the correct structure

Smoke Test: Create New Object
    [Documentation]    Quick test to verify creating a new object
    Given the API is accessible
    When I send a POST request to create a new object
    Then the response status code should be 200
    And the response should contain the created object details

Smoke Test: Update Existing Object
    [Documentation]    Quick test to verify updating an existing object
    Given the API is accessible
    When I send a PUT request to update an existing object
    Then the response status code should be 200
    And the response should contain the updated object details

Smoke Test: Delete Existing Object
    [Documentation]    Quick test to verify deleting an existing object
    Given the API is accessible
    When I send a DELETE request to delete an existing object
    Then the response status code should be 200
    And the response should confirm the deletion

*** Keywords ***
Create Object for Suite
    [Documentation]    Create an object to be used in all test cases
    ${nested_data}=    Create Dictionary    year=2019    price=1849.99
    ...    CPU model=Intel Core i9    Hard disk size=1 TB
    ${data}=    Create Dictionary    name=Apple MacBook Pro 16    data=${nested_data}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${BASE_URL}    json=${data}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_response}=    Set Variable    ${response.json()}
    ${object_id}=    Set Variable    ${json_response}[id]
    Set Suite Variable    ${OBJECT_ID}    ${object_id}
    Log    Created object with ID: ${OBJECT_ID}

