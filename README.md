# Zabbix Server Setup Script

This script automates the installation and configuration of a Zabbix server on a Debian-based system. 

## What is Zabbix?

[Zabbix](https://www.zabbix.com/) is an open-source monitoring software for networks and applications. It allows you to monitor and track the status of various network services, servers, and other network hardware. Zabbix provides real-time monitoring, alerting, and visualization of collected data.

## Script Overview

This script performs the following steps:

1. **Prompt for Zabbix Database User Password**: Asks for the password of the Zabbix database user.
2. **Install Zabbix Repository and Update APT Repository**: Downloads and installs the Zabbix repository package and updates the APT repository.
3. **Install Zabbix Server, Frontend, Agent**: Installs Zabbix server, frontend, agent, along with necessary PHP and PostgreSQL packages.
4. **Create Initial Database**: Creates an initial PostgreSQL database and user for Zabbix.
5. **Import Initial Schema and Data**: Imports the initial schema and data into the Zabbix database.
6. **Configure the Database for Zabbix Server**: Configures the database password in the Zabbix server configuration file.
7. **Start Zabbix Server and Agent Processes**: Restarts the Zabbix server, agent, and Apache services.
8. **Enable Zabbix Services at Boot**: Enables Zabbix server, agent, and Apache services to start automatically at boot.
9. **Get IP Address**: Retrieves the IP address of the machine for accessing the Zabbix web interface.

## How to Use

1. Run the script.
2. Enter the Zabbix database user password when prompted.
3. After successful execution, access the Zabbix web interface by navigating to `http://<IP_ADDRESS>/zabbix`, where `<IP_ADDRESS>` is the IP address of your machine.

## Note

- This script assumes a Debian-based operating system.
- Ensure that the script is executed with appropriate permissions.
- Make sure to review and customize the script as per your environment requirements before execution.
