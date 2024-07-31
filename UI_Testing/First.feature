Feature: Example
# Feature File for the Example
Scenario: FinishME
    when I start the browser
    And  I Navigate to 'https://www.example.com/'
    And  I click on the 'More information...' link
    Then a link with text 'RFC 2606' must be present
    And  a link with text 'RFC 6761' must be present
 # As we have not the element in this page I clicked on the "IANA-managed Reserved Domains" link to retrieve the record
    And  the 'Domain Names' box must contain 'Root Zone Management' at index '2'

