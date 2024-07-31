import os
import subprocess
from datetime import datetime

# Get the current directory
current_dir = os.path.dirname(os.path.abspath(__file__))

# Define the paths
test_file = os.path.join(current_dir, 'Tests', 'api_smoke_tests.robot')
reports_dir = os.path.join(current_dir, 'Reports')

# Ensure the Reports directory exists
os.makedirs(reports_dir, exist_ok=True)

# Check if the test file exists
if not os.path.exists(test_file):
    print(f"Error: Test file not found: {test_file}")
    exit(1)

# Create a timestamp for unique report folders
output_dir = os.path.join(reports_dir, f"run_{datetime.now().strftime('%Y%m%d_%H%M%S')}")

# Construct the robot command
robot_command = [
    "robot",
    f"--outputdir={output_dir}",
    test_file
]

# Run the robot command
try:
    subprocess.run(robot_command, check=True)
    print(f"Tests completed successfully. Reports saved in: {output_dir}")
except subprocess.CalledProcessError as e:
    print(f"An error occurred while running the tests: {e}")