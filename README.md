# Automated Payload Searcher 

## **Overview**

This CLI tool is designed for cybersecurity professionals and enthusiasts to perform reconnaissance on a target URL. It utilizes **Nmap** for network scanning and **msfvenom** to identify potential payloads based on the services detected during the scan.

## **Features**

- **Nmap Scanning**: Performs a fast scan to identify open ports and services running on the target URL.
- **Payload Identification**: Searches for relevant payloads in **msfvenom** based on the detected services and their versions.
- **User Interaction**: Prompts the user to select a specific payload from the identified options.

## **Prerequisites**

Before using this tool, ensure that you have the following installed:

- **Nmap**: A powerful network scanning tool.
- **Metasploit Framework**: Includes **msfvenom** for payload generation.

You can install these tools using the following commands:

```bash
sudo apt update
sudo apt install nmap metasploit-framework
```
## **Installation**
Clone this repository or download the script:
````bash
git clone <repository-url>
cd <repository-directory>
````
Make the script executable:
```bash
chmod +x cyber_tool.sh
````
Usage
Run the script by providing a target URL as an argument:
```bash
./cyber_tool.sh http://example.com
````
The tool will perform the following actions:

- Execute an Nmap scan on the provided URL.
- Analyze the scan results to identify running services and their versions.
- Search for relevant payloads in msfvenom.
- Prompt the user to select a payload from the list of available options.
  
*Notes*
Ensure you have permission to scan the target URL to avoid legal issues.
The script outputs results to nmap_results.txt for review.
Contributing
Feel free to submit issues or pull requests if you have suggestions or improvements for this tool.

*License*
This project is licensed under the MIT License - see the LICENSE file for details.
