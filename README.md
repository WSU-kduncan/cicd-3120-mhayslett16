# Project 5  
  
# Project Overview  
For Project 5, we will create a new repository (mostly for organization purposes). The goal of the project will be to use Docker to containerize an application, automate the project pipeline with GitHub Actions, and explore webhooks.  
  
# Part 1: Dockerize it  
  
  
## Documentation  
Running the project locally:  
- First off, I created a separate repository for Project5 using the link provided in Pilot. I cloned this repository onto my local machine and established credentials so that I can push and pull between my machine and GitHub.
- I then installed Docker Desktop onto my local computer. I set it up to be used with WSL2 and Ubuntu, since those are the resources that will be used for this project.  
- To install Docker onto my local Ubuntu image, I followed the guide available at https://dev.to/bartr/install-docker-on-windows-subsystem-for-linux-v2-ubuntu-5dl7. The commands to setup Docker on the Ubuntu image were pretty much identical, so I simply followed the given commands, skipping the optional ones.  
- To check to make sure Docker was installed and working properly, I ran the command "sudo docker run -it hello-world", and the following was output, indicating a successful installation:  
![docker installation](https://github.com/WSU-kduncan/cicd-3120-mhayslett16/blob/main/docker-installed.JPG)  
- To install Docker, you must have WSL2 installed onto your Windows machine, which requires Windows 10 build 18917 or higher. Other dependencies include updating the Ubuntu package manager using "sudo apt-get update", as well as installing some other prerequesites that are outlined in the installation guide mentioned and linked above.  
- Building the container image that is used to run the project requires you to create an HTML file with the contents of your website. For this project, I used a basic HTML file that just states that it's running Project5. The web contents should be placed in a "website" folder under the Git repository folder in the local machine. I named this file "index.html".  
- I then created a Dockerfile (I placed this in the "website" folder as well). I used the guide from https://hub.docker.com/_/httpd to create a simple httpd container through the Dockerfile.  
- I used the guide to build the image as well, using the command "sudo docker build -t my-apache2 ." (please notice the "." because I kept missing it and getting errors.)  
- You can test to make sure your image has been created by running "sudo docker images" and checking for the name of the image you attempted to build in the previous command.  
- After verifying that the image has been created, you can run it. I used the command "sudo docker run -dit --name my-running-app -p 8080:80 my-apache2". This runs the container as a process called "my-running-app", and pulls from the "my-apache2" image to run a local connection over port 8080.  
- You can view the project by opening a web browser and typing into the search bar:" localhost:8080 ".  
- You can use the command "sudo docker ps" to make sure the process is running.  
- And with that, your HTML page should be running on your local network. Here's an example of what mine looks like running on my personal laptop over my home Wi-Fi connection:  
![Site running locally](https://github.com/WSU-kduncan/cicd-3120-mhayslett16/blob/main/running-site.JPG)
  
  
***Site content and Dockerfile are available under the "website" folder of this repository***
  
  
# Part 2: GitHub Actions and DockerHub  
  
  
(To be submitted for Milestone 2; due 4/7/2022)  
    
Creating a DockerHub Public Repo:  
- Simply log into your DockerHub account and click the "Create Repository" button under the Repository tab. You can make an unlimited amount of public repo's with a standard account. You can customize their name and description before hitting "create" to finish the process. 
   
Allow DockerHub Authentication  via CLI using DockHub Credentials:  
- To allow for CLI authentication, we'll need to create an access token for our dockerhub repo. Do this by selecting your username in dockerhub and selecting "Account Settings". Scroll down to the "Security" option and click "New Access Token". Give your token a description and select the permissions you'd like to give it before clicking "Generate" at the bottom right. Copy this access token and save it somewhere for later use.  
  
Configure GitHub Secrets:  
- Under the "Settings" tab in your repo, select the expand option for "Secrets".
From these options, select "Actions". In the top right, select "New Repository S
ecret". Create a secret called "DOCKER_USERNAME" and type your username into the
 value box. Create another secret called "DOCKER_PASSWORD" and type the token we created in the last section into the value box.  
  
Configure GitHub Workflow:  
- To configure GitHub Workflow, I mainly followed the walkthrough provided during a few of the class recordings. Looking at the project-p2.yml file created in the /.github/workflows folder, I mostly used the same content and syntax as used in the example. However, the DOCKER_REPO is set to my dockerhub repo's name, and the username and password are connected to the secrets on my personal github account. 
- Side note: This part of the project gave me a lot of issues and I am stubborn, so I continued to change bit by bit until I got the repo pushed to my dockerhub. I kept getting an error with buildx and failing to compute a cache key. I ended up just copying the contents of the website and Dockerfile created in Part 1 out of the websites folder and onto the main repo folder. I'm sure there was an easier way to fix the issue, but I'm just glad I got to see the checkmark after 15 attempts at it. Is it right? Honestly, I don't know. Rant over. 
  
  
# Part 3: Deployment  
  
  
Container Restart Script:  
-
  
Webhook Task Definition File:  
- 
  
Setting up a webhook on the server:  
- 
- 
  
Setting up a notifier in GitHub or DockerHub  
-  
  
  
  
# Part 4: Diagramming
  
## Documentation  

