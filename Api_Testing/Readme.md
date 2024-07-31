# API Testing with Robot Framework
This project contains automated API tests for the RESTful API at https://api.restful-api.dev/objects using Robot Framework.


## Prerequisites
- Python 3.x
- Robot Framework
- RequestsLibrary for Robot Framework

## Installation
1. Clone this repository:
    git clone <repository-url>
    cd Api_Testing
2. Install the required Python packages:
    pip install -r requirements.txt OR pip install robotframework robotframework-requests

## Running the Tests

To run the tests, execute the `Run.py` script from the command line:
    python3 Run.py


This script will:
- Execute the Robot Framework tests located in the `Tests` directory
- Generate test reports in the `Reports` directory

## Test Cases

The `api_smoke_tests.robot` file contains the following smoke tests:

1. Retrieve Objects: Verifies GET request to fetch objects
2. Create New Object: Tests POST request to create a new object
3. Update Existing Object: Checks PUT request to update an object
4. Delete Existing Object: Validates DELETE request to remove an object

## Test Structure

- The tests use a suite setup to create an initial object used across test cases.
- Each test case follows the Given-When-Then structure for better readability.
- Custom keywords are used to encapsulate common API operations.

## Reporting

After running the tests, you can find the generated reports in the `Reports` directory. The reports include:
- `log.html`: Detailed test execution log
- `report.html`: Overview of test results
- `output.xml`: Raw output data

## Contact
For questions, reach out at Mostafaeialiii@gmail.com.
