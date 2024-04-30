# Jenkins
Configure Jernkins, set up cicd, deploy applications to k8s and much more.


### Login to Jenkins using the below URL:

http://ec2-instance-public-ip-address:8080    

Note: If you are not interested in allowing `All Traffic` to your EC2 instance
      1. Edit the inbound traffic rule to only allow custom TCP port `8080`
  
After you login to Jenkins, 
      - Run the command to copy the Jenkins Admin Password - `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
      - Enter the Administrator password


## Install the Docker Pipeline plugin in Jenkins:

   - Log in to Jenkins.
   - Go to Manage Jenkins > Manage Plugins.
   - In the Available tab, search for "Docker Pipeline".
   - Select the plugin and click the Install button.


## Install the Sonar scanner plugin in Jenkins:

   - Log in to Jenkins.
   - Go to Manage Jenkins > Manage Plugins.
   - In the Available tab, search for "Sonar scanner".
   - Select the plugin and click the Install button.

## Install the Nexus plugin in Jenkins:

   - Log in to Jenkins.
   - Go to Manage Jenkins > Manage Plugins.
   - In the Available tab, search for "Nexus".
   - Select the plugin and click the Install button.

Once you are done with the above steps, it is better to restart Jenkins.

```
http://<ec2-instance-public-ip>:8080/restart
```

## Add credentials 

github-tonken 
dockerhub-cred
sonar-token 





