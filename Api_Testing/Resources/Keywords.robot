*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Resource    Variables.robot

*** Keywords ***
Given the API is accessible
    No Operation

When I send a GET request to retrieve objects
    ${response}=    GET    ${BASE_URL}
    Set Test Variable    ${response}

When I send a POST request to create a new object
    ${nested_data}=    Create Dictionary    year=2019    price=1849.99
    ...    CPU model=Intel Core i9    Hard disk size=1 TB
    ${data}=    Create Dictionary    name=Apple MacBook Pro 16    data=${nested_data}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${BASE_URL}    json=${data}    headers=${headers}
    Set Test Variable    ${response}

When I send a PUT request to update an existing object
    ${nested_data}=    Create Dictionary    year=2019    price=2049.99
    ...    CPU model=Intel Core i9    Hard disk size=1 TB    color=silver
    ${data}=    Create Dictionary    name=Apple MacBook Pro 16    data=${nested_data}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    PUT    ${BASE_URL}/${OBJECT_ID}    json=${data}    headers=${headers}
    Set Test Variable    ${response}

When I send a DELETE request to delete an existing object
    ${response}=    DELETE    ${BASE_URL}/${OBJECT_ID}
    Set Test Variable    ${response}

Then the response status code should be 200
    Should Be Equal As Numbers    ${response.status_code}    200

And the first object should have the correct structure
    ${first_object}=    Set Variable    ${response.json()}[0]
    Dictionary Should Contain Key    ${first_object}    id
    Dictionary Should Contain Key    ${first_object}    name
    Dictionary Should Contain Key    ${first_object}    data

And the response should contain the created object details
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    id
    Dictionary Should Contain Key    ${json_response}    name
    Dictionary Should Contain Key    ${json_response}    createdAt
    Dictionary Should Contain Key    ${json_response}    data
    Should Be Equal    ${json_response}[name]    Apple MacBook Pro 16
    Should Be Equal As Integers    ${json_response}[data][year]    2019
    Should Be Equal As Numbers    ${json_response}[data][price]    1849.99
    Should Be Equal    ${json_response}[data][CPU model]    Intel Core i9

And the response should contain the updated object details
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    id
    Dictionary Should Contain Key    ${json_response}    name
    Dictionary Should Contain Key    ${json_response}    updatedAt
    Dictionary Should Contain Key    ${json_response}    data
    Should Be Equal    ${json_response}[name]    Apple MacBook Pro 16
    Should Be Equal As Integers    ${json_response}[data][year]    2019
    Should Be Equal As Numbers    ${json_response}[data][price]    2049.99
    Should Be Equal    ${json_response}[data][CPU model]    Intel Core i9
    Should Be Equal    ${json_response}[data][color]    silver

And the response should confirm the deletion
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    message
    Should Be Equal As Strings    ${json_response}[message]    Object with id = ${OBJECT_ID} has been deleted.