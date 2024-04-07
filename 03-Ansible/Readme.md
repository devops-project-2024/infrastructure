# Installing ansible

To install Ansible, follow the instructions below 

### For Ubuntu (and other Debian-based systems):

1. **Update the package list**:
   
   ```bash
   sudo apt update
   ```

2. **Install the software-properties-common package**:

   ```bash
   sudo apt install software-properties-common
   ```

3. **Add the Ansible PPA (Personal Package Archive) to the system**:

   ```bash
   sudo add-apt-repository ppa:ansible/ansible
   ```

4. **Update the package list again**:

   ```bash
   sudo apt update
   ```

5. **Install Ansible**:

   ```bash
   sudo apt install ansible
   ```

### For CentOS/RHEL:

1. **Install the EPEL (Extra Packages for Enterprise Linux) repository**:

   ```bash
   sudo yum install epel-release
   ```

2. **Install Ansible**:

   ```bash
   sudo yum install ansible
   ```

### For Fedora:

1. **Install Ansible directly with dnf**:

   ```bash
   sudo dnf install ansible
   ```

### For macOS:

1. **Install Homebrew** if it's not already installed (visit [Homebrew's website](https://brew.sh) for the latest command):

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Ansible** with Homebrew:

   ```bash
   brew install ansible
   ```

### For Windows:

Ansible does not run natively on Windows, but you can use it within the Windows Subsystem for Linux (WSL), a virtual machine, or a container. To set up Ansible in WSL:

1. **Enable WSL on Windows** (requires Windows 10 or later):

   - Open PowerShell as Administrator and run:

     ```powershell
     dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
     ```

   - Restart your computer if needed and install a Linux distribution from the Microsoft Store (like Ubuntu).