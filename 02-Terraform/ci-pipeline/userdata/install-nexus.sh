#!/bin/bash

#### 1. Set hostname, Add Nexus as a user and to the Sudors file.
hostnamectl set-hostname nexus
timedatectl set-timezone America/New_York
useradd nexus
echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus

#### 2. Install Java JDK 11+ as a prerequisite for Nexus to run.
yum install wget tree vim unzip git-all -y
yum install java-1.8.0-openjdk-devel -y  # Ensure Java 11 or newer is installed

#### 3. Download, extract, and Install Nexus
cd /opt
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -zxvf latest-unix.tar.gz
mv /opt/nexus-3* /opt/nexus
rm -rf latest-unix.tar.gz

#### 4. Set ownership permissions to Nexus
chown -R nexus:nexus /opt/nexus
chown -R nexus:nexus /opt/sonatype-work
chmod -R 775 /opt/nexus
chmod -R 775 /opt/sonatype-work

#### 5. Run Nexus as a user by modifying run_as_user in nexus.rc
echo 'run_as_user="nexus"' > /opt/nexus/bin/nexus.rc

#### 6. Create a symbolic link for Nexus
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus

#### 7. Create a service file for Nexus
cat > /etc/systemd/system/nexus.service <<EOF
[Unit]
Description=Nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/etc/init.d/nexus start
ExecStop=/etc/init.d/nexus stop 
User=nexus
Restart=always

[Install]
WantedBy=multi-user.target
EOF

#### 8. Enable and start the Nexus service
sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service
sudo systemctl status nexus.service