# DNS Changer Tool

## Overview

This script allows users to easily change the DNS (Domain Name System) settings for their network interfaces on Windows. It can be used to switch between common public DNS services or manually configure custom DNS settings. The script requires administrative privileges to modify the system's network settings.

## Features

- **Check Current DNS Configuration**: Displays the current DNS settings for the selected network interface.
- **Set DNS to Dynamic (DHCP)**: Reverts DNS settings to be automatically assigned by the DHCP server.
- **Set Static DNS**: Allows you to set DNS servers manually, with popular options such as:
  - Google DNS
  - Cloudflare DNS
  - AdGuard DNS
  - OpenDNS (Cisco)
  - Quad9 DNS
  - CleanBrowsing DNS
  - Comodo Secure DNS
- **Set Local Pi-hole DNS**: Configures a local Pi-hole server for DNS resolution.
- **Manual DNS Setup**: Allows you to manually input primary and secondary DNS addresses.

## Usage

1. **Run the Script as Administrator**: Ensure you have administrator privileges, as the script requires elevated rights to modify network settings.
2. **Select Network Interface**: Choose between Ethernet or Wi-Fi to configure the DNS for the desired interface.
3. **Choose DNS Configuration**: After displaying the current DNS settings, select from predefined DNS options or set a custom DNS address.
4. **Manual DNS Configuration**: If you choose the manual option, you will be prompted to enter primary and secondary DNS addresses.

## DNS Options Explained

- **Dynamic (DHCP)**: This option reverts your DNS settings to the default automatic configuration provided by your DHCP server (usually your router).
  
- **Google DNS**: Google's public DNS servers (`8.8.8.8` and `8.8.4.4`) offer fast and reliable DNS resolution with no filtering.

- **Cloudflare DNS**: Cloudflare's DNS (`1.1.1.1`) focuses on privacy and speed, promising no logging of your browsing activity.

- **AdGuard DNS**: AdGuard DNS (`94.140.14.140` and `94.140.15.15`) provides both privacy protection and content blocking to prevent access to malicious websites and advertisements.

- **OpenDNS (Cisco)**: OpenDNS (`208.67.222.222` and `208.67.220.220`) is a DNS service by Cisco, offering both security features and customizable filtering options.

- **Quad9 DNS**: Quad9 DNS (`9.9.9.9` and `149.112.112.112`) provides strong security against known malicious websites.

- **CleanBrowsing DNS**: CleanBrowsing DNS (`185.228.168.168` and `185.228.169.168`) offers safe browsing by blocking adult content and malware.

- **Comodo Secure DNS**: Comodo Secure DNS (`8.26.56.26` and `8.20.247.20`) focuses on providing security and protecting users from phishing sites and malware.

- **Pi-hole DNS**: If you have a local Pi-hole server, you can configure your system to use it as the DNS resolver by setting the IP address to `192.168.0.100`.

## Requirements

- **Administrator Rights**: The script needs to be run with administrator privileges to modify network settings.
- **Windows OS**: This script is designed to run on Windows systems.

## How to Run

1. Download or copy the script to your machine.
2. Right-click on the script file and select **Run as Administrator**.
3. Follow the prompts to choose the network interface and the DNS configuration you wish to apply.

## Disclaimer

- **Security Warning**: Always ensure you are using a trusted DNS service. DNS servers can track your browsing history, so choose a provider with a privacy policy that aligns with your needs.
- **Pi-hole**: If you're using Pi-hole, ensure it is running on your local network before selecting the Pi-hole DNS option.

## Contact

- **Instagram**: [@daniell.leall](https://www.instagram.com/daniell.leall)
- **YouTube**: [@daniell_leall](https://www.youtube.com/@daniell_leall)

Thank you for using the DNS Changer Tool! Stay secure and happy browsing.