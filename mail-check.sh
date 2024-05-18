#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to check DMARC record
check_dmarc() {
 local domain=$1
 local dmarc_record=$(dig +short txt "_dmarc.$domain")
 if [[ "$dmarc_record" == *"v=DMARC1"* ]]; then
 echo -e "${GREEN}DMARC record found for $domain:${NC}"
 echo "$dmarc_record"
 if echo "$dmarc_record" | grep -qE "p=(quarantine|reject)"; then
 echo -e "${RED}DMARC policy (quarantine or reject) is enforced.${NC}"
 else
 echo -e "${YELLOW}DMARC policy is set to none or missing, which is not enforced.${NC}"
 fi
 else
 echo -e "${YELLOW}No DMARC record found for $domain.${NC}"
 fi
}

# Function to check SPF record
check_spf() {
 local domain=$1
 local spf_record=$(dig +short txt "$domain" | grep "v=spf1")
 if [ -n "$spf_record" ]; then
 echo -e "${GREEN}SPF record found for $domain:${NC}"
 echo "$spf_record"
 if echo "$spf_record" | grep -qE "\-all"; then
 echo -e "${GREEN}SPF policy is set to hard fail (-all).${NC}"
 elif echo "$spf_record" | grep -qE "\~all"; then
 echo -e "${YELLOW}SPF policy is set to soft fail (~all). Consider setting it to hard fail (-all) for stricter security.${NC}"
 else
 echo -e "${YELLOW}SPF policy does not specify a fail condition explicitly.${NC}"
 fi
 else
 echo -e "${YELLOW}No SPF record found for $domain.${NC}"
 fi
}

# Function to check DKIM record
# Note: This is a simple check for common selector 'default'. Adjust as necessary for specific use cases.
check_dkim() {
 local domain=$1
 local dkim_record=$(dig +short txt "default._domainkey.$domain")
 if [ -n "$dkim_record" ]; then
 echo -e "${GREEN}DKIM record found for $domain:${NC}"
 echo "$dkim_record"
 else
 echo -e "${YELLOW}No DKIM record found for $domain.${NC}"
 fi
}

# Main script logic
case "$1" in
 -f)
 if [ -n "$2" ] && [ -f "$2" ]; then
 file=$2
 while IFS= read -r domain || [ -n "$domain" ]; do
 check_dmarc "$domain"
 check_spf "$domain"
 check_dkim "$domain"
 done < "$file"
 else
 echo -e "${RED}File not specified or does not exist.${NC}"
 fi
 ;;
 -d)
 if [ -n "$2" ]; then
 domain=$2
 check_dmarc "$domain"
 check_spf "$domain"
 check_dkim "$domain"
 else
 echo -e "${RED}Domain not specified.${NC}"
 fi
 ;;
 *)
 echo "Usage: $0 -f <file> | -d <domain>"
 exit 1
 ;;
esac
