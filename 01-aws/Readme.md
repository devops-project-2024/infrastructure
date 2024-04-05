# Installing and Configuring AWS CLI on Ubuntu

This README provides instructions on how to install the AWS Command Line Interface (AWS CLI) on an Ubuntu system and how to configure it to interact with AWS services.

## Prerequisites

- An Ubuntu machine (16.04 or later is recommended).
- An AWS account and credentials (Access Key ID and Secret Access Key).

## Installation

1. **Update Your Package Repository**

   Open a terminal and run the following command to ensure your package listings are up to date:

   ```bash
   sudo apt update
   ```

2. **Install the Unzip Utility**

   If you don't have `unzip` installed, install it by running:

   ```bash
   sudo apt install unzip
   ```

3. **Download the AWS CLI**

   Download the latest version of the AWS CLI using `curl`:

   ```bash
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   ```

4. **Unzip the Installer**

   Unzip the downloaded file:

   ```bash
   unzip awscliv2.zip
   ```

5. **Run the Installation Script**

   Execute the installation script:

   ```bash
   sudo ./aws/install
   ```

   This command will install the AWS CLI under `/usr/local/bin`.

6. **Verify the Installation**

   Ensure the AWS CLI installed correctly by running:

   ```bash
   aws --version
   ```

   This command should display the version of the AWS CLI installed.

## Configuration

1. **Configure AWS CLI**

   To configure the AWS CLI, you’ll need your AWS Access Key ID and Secret Access Key. Start the configuration process by running:

   ```bash
   aws configure
   ```

   When prompted, enter the following:

   - `AWS Access Key ID`: Enter your access key ID.
   - `AWS Secret Access Key`: Enter your secret access key.
   - `Default region name`: Enter your default region (e.g., `us-west-2`).
   - `Default output format`: Enter your preferred output format (e.g., `json`).

2. **Verify Configuration**

   To check if the AWS CLI is properly configured, you can list your S3 buckets as a test command:

   ```bash
   aws s3 ls
   ```

   If the configuration is correct, you should see a list of your S3 buckets (if any exist).

## Conclusion

You now have the AWS CLI installed and configured on your Ubuntu machine. You can use it to manage and interact with AWS services directly from your terminal. For detailed AWS CLI commands and options, refer to the [official AWS CLI documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html).