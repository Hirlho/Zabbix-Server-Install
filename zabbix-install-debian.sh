#!/bin/bash

# Function to display the result of the step.
function step_result {
    if [ $? -eq 0 ]; then
        echo -e "\e[32mOK\e[0m - $1"
    else
        echo -e "\e[31mKO\e[0m - $1"
        exit 1
    fi
}


# Prompt for Zabbix database user password
read -s -p "Enter Zabbix database user password: " ZABBIX_DB_PASSWORD
echo

# Install Zabbix repository and update apt repository
wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian12_all.deb
dpkg -i zabbix-release_6.4-1+debian12_all.deb
apt update
step_result "Installing Zabbix repository and updating apt repository"

# Install Zabbix server, frontend, agent
apt install -y zabbix-server-pgsql zabbix-frontend-php php8.2-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent postgresql
step_result "Installing Zabbix components"

# Create initial database
sudo -u postgres psql -c "CREATE USER zabbix WITH PASSWORD '$ZABBIX_DB_PASSWORD';"
sudo -u postgres createdb -O zabbix zabbix 
step_result "Creating Zabbix database and user"

# On Zabbix server host import initial schema and data. You will be prompted to enter your newly created password.
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix 
step_result "Importing initial schema and data"

# Configure the database for Zabbix server
sed -i "s/# DBPassword=/DBPassword=$ZABBIX_DB_PASSWORD/" /etc/zabbix/zabbix_server.conf
step_result "Configuring Zabbix server database"

# Start Zabbix server and agent processes
systemctl restart zabbix-server zabbix-agent apache2
step_result "Restarting Zabbix server, agent, and Apache"

systemctl enable zabbix-server zabbix-agent apache2
step_result "Enabling Zabbix server, agent, and Apache at boot"

# Get the IP address of the machine
IP_ADDRESS=$(hostname -I | awk '{print $1}')

echo "Zabbix setup completed successfully."
echo "You can access Zabbix web interface by navigating to http://$IP_ADDRESS/zabbix"
