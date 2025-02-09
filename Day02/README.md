# Bucket Summary and Deletion Script

This script is designed to process a JSON file containing information about storage buckets, summarize the data, and identify buckets that exceed a specified size threshold for potential deletion. The script uses Python's built-in libraries to handle file operations, JSON parsing, and even emoji rendering for enhanced readability.

## Overview

The script performs two main functions:

1. **Summarizing Bucket Information**: It reads bucket data from a JSON file and writes a summary of each bucket's attributes (name, region, size, and versioning status) to a text file named `summary.txt`.

2. **Identifying Buckets for Deletion**: It identifies buckets that exceed a size threshold (100 GB in this case) and writes their details to another text file named `delete.txt`. Additionally, it uses an emoji to visually highlight that these buckets need attention.

## Key Concepts

### JSON File Input
The script expects a JSON file named `buckets.json` as input. This file should contain a list of buckets, each with attributes such as `name`, `region`, `sizeGB`, and `versioning`. The script reads this file to extract and process the bucket data.

### Summary Generation
The script generates a summary of all buckets by iterating through the list and writing their details to `summary.txt`. This file serves as a consolidated report of all buckets, making it easier to review their configurations.

### Deletion Identification
The script identifies buckets that are larger than 100 GB and writes their details to `delete.txt`. This file is intended to help administrators quickly identify buckets that may need to be deleted or archived due to their size. The use of an emoji (⚠️) adds a visual cue to draw attention to these entries.

### Error Handling
The script includes basic error handling to ensure that the JSON file has the expected structure. If the file is missing the `buckets` key or if any bucket lacks the required attributes, the script will exit with an error message.

## How It Works

1. **Reading the JSON File**: The script opens and reads the `buckets.json` file, loading its contents into a Python dictionary.

2. **Writing the Summary**: It iterates through each bucket in the JSON data and writes its details to `summary.txt`. This includes the bucket's name, region, size, and versioning status.

3. **Identifying Large Buckets**: The script checks the size of each bucket. If a bucket's size exceeds 100 GB, its details are written to `delete.txt` along with a warning emoji.

4. **Error Handling**: If the JSON file is missing required keys or has an invalid structure, the script will exit and display an error message.

## Usage

To use this script:

1. Ensure you have a valid `buckets.json` file in the same directory as the script.
2. Run the script using Python.
3. Review the generated `summary.txt` and `delete.txt` files for the bucket summaries and deletion recommendations, respectively.

## Dependencies

- **Python 3.x**: The script is written in Python and requires Python 3.x to run.
- **`emoji` Library**: The script uses the `emoji` library to render warning symbols in the `delete.txt` file. Install it using `pip install emoji`.

## Example JSON Structure

Here is an example of what the `buckets.json` file might look like:

```json
{
    "buckets": [
        {
            "name": "bucket1",
            "region": "us-east-1",
            "sizeGB": 50,
            "versioning": "enabled"
        },
        {
            "name": "bucket2",
            "region": "eu-west-1",
            "sizeGB": 150,
            "versioning": "disabled"
        }
    ]
}
```
## Output Files
- **summary.txt**: Contains a summary of all buckets.

- **delete.txt**: Contains details of buckets that exceed the size threshold, marked with a warning emoji.

### Notes
Ensure the buckets.json file is correctly formatted and contains the necessary keys.

The size threshold for identifying buckets for deletion is set to 100 GB. You can modify this value in the script if needed.

The script appends to summary.txt and delete.txt on each run, so these files may contain duplicate entries if the script is run multiple times.