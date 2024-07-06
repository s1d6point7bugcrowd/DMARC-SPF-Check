# Email Authentication Checker

This script checks the DMARC, SPF, and DKIM records for a given domain or a list of domains. It provides detailed information about the email authentication policies in place for each domain.

## Features

- **DMARC Record Check**: Verifies the presence and policy of DMARC records.
- **SPF Record Check**: Verifies the presence and policy of SPF records.
- **DKIM Record Check**: Verifies the presence of DKIM records for the default selector.
- **Color-coded Output**: Provides easy-to-read, color-coded output indicating the status of each record.

  The script relies on a few dependencies and commands that need to be available on the system where it is executed.
Dependencies

    bash
        The script is written in bash and requires the Bash shell to be installed on your system.

    dig
        dig (Domain Information Groper) is a command-line tool used for querying DNS name servers.
        It is typically part of the bind-utils or dnsutils package, depending on the Linux distribution.

    Color Support
        The script uses ANSI escape codes to print colored text in the terminal. This requires a terminal that supports ANSI escape codes.

Installation of Dependencies

    Installing dig:
        On Debian-based systems (e.g., Ubuntu):

        

sudo apt-get update
sudo apt-get install dnsutils

On Red Hat-based systems (e.g., CentOS, Fedora):



        sudo yum install bind-utils

Verifying Dependencies

    Check if bash is installed:
        This is usually pre-installed on most Unix-like operating systems.
        To check the version of Bash:

        

    bash --version

Check if dig is installed:

    To verify if dig is installed and accessible:

    

        dig -v

Additional Notes

    The script assumes that the DNS servers are reachable and that the network configuration allows DNS queries.
    Ensure your terminal supports ANSI escape codes to see the colored output correctly.

Usage

You can run the script with either a single domain or a file containing a list of domains.
Check a Single Domain

To check a single domain, use the -d option followed by the domain name: ./check_email_auth.sh -d example.com


Check Multiple Domains from a File

To check multiple domains, use the -f option followed by the filename. Each line in the file should contain one domain: ./check_email_auth.sh -f domains.txt

The script includes basic error handling to manage exceptions such as missing or invalid files and domains. If an error occurs, it will print an error message and continue execution.


Contributions are welcome! If you have suggestions for improvements or find a bug, please open an issue or submit a pull request.


