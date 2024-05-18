# Email Authentication Checker

This script checks the DMARC, SPF, and DKIM records for a given domain or a list of domains. It provides detailed information about the email authentication policies in place for each domain.

## Features

- **DMARC Record Check**: Verifies the presence and policy of DMARC records.
- **SPF Record Check**: Verifies the presence and policy of SPF records.
- **DKIM Record Check**: Verifies the presence of DKIM records for the default selector.
- **Color-coded Output**: Provides easy-to-read, color-coded output indicating the status of each record.

Usage

You can run the script with either a single domain or a file containing a list of domains.
Check a Single Domain

To check a single domain, use the -d option followed by the domain name: ./check_email_auth.sh -d example.com


Check Multiple Domains from a File

To check multiple domains, use the -f option followed by the filename. Each line in the file should contain one domain: ./check_email_auth.sh -f domains.txt

The script includes basic error handling to manage exceptions such as missing or invalid files and domains. If an error occurs, it will print an error message and continue execution.


Contributions are welcome! If you have suggestions for improvements or find a bug, please open an issue or submit a pull request.


