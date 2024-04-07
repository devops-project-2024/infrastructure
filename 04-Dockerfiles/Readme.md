# Install docker

step-by-step instructions for installing Docker on Ubuntu

### 1. Update the package index

Before installing any new packages, it's a good practice to update the package index.

```bash
sudo apt-get update
```

### 2. Install required packages

Install `ca-certificates` and `curl`, which are required to fetch the Docker GPG key and add the Docker repository.

```bash
sudo apt-get install ca-certificates curl
```

### 3. Create a directory for APT keyrings

Create a directory to store the Docker GPG key used by APT to verify package integrity.

```bash
sudo install -m 0755 -d /etc/apt/keyrings
```

### 4. Add Docker’s official GPG key

Download the Docker GPG key to ensure the packages are signed by the official Docker source.

```bash
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
```

### 5. Set permissions for the Docker GPG key

Make sure the GPG key is readable, which is necessary for APT to use it.

```bash
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

### 6. Add the Docker repository

Add the Docker repository to APT's sources list. This command uses the shell to determine the architecture and version codename of your Ubuntu distribution automatically.

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 7. Update the package index again

After adding the new repository, update the package index again to include the newly added Docker packages.

```bash
sudo apt-get update
```

### 8. Install Docker packages

Install Docker Engine (`docker-ce`), Docker CLI (`docker-ce-cli`), container runtime (`containerd.io`), and the latest Docker plugins (`docker-buildx-plugin`, `docker-compose-plugin`).

```bash
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 9. Add your user to the Docker group

Adding your user (in this case, `ubuntu`) to the `docker` group allows running Docker commands without `sudo`.

```bash
sudo usermod -aG docker ubuntu
```

### 10. Restart Docker

Restart the Docker service to apply any changes and ensure everything is running correctly.

```bash
sudo systemctl restart docker
```

## How to run docker-compose file

### 1. Navigate to Your Project Directory

Change to the directory containing your `docker-compose.yml` file:

```bash
cd ~/infrastructure/04-Dockfiles/Sonarqube
```

Ensure the `docker-compose.yml` file exists in this directory.

### 2. Running Docker Compose

To start and run the entire application defined in `docker-compose.yml`, execute:

```bash
docker-compose up
```

- Use the `-d` flag to run containers in the background (detached mode):

  ```bash
  docker-compose up -d
  ```

### 3. Stopping Docker Compose Services

To stop the services started by Docker Compose, you can use:

```bash
docker-compose down
```

This command stops and removes all the containers defined in the `docker-compose.yml` file. If you only want to stop the services without removing the containers, use:

```bash
docker-compose stop
```

### 4. Managing Services

- To restart a service:

  ```bash
  docker-compose restart [service_name]
  ```

- To view logs of a service:

  ```bash
  docker-compose logs [service_name]
  ```

