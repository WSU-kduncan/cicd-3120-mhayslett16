# cicd-3120-mhayslett16
Working Connection, enjoy this placeholder text
Source for docker installation walkthrough: https://dev.to/bartr/install-docker-on-windows-subsystem-for-linux-v2-ubuntu-5dl7
https://hub.docker.com/_/httpd 
#Project 5  
  
#Project Overview  
For Project 5, we will create a new repository (mostly for organization purposes). The goal of the project will be to use Docker to containerize an application, automate the project pipeline with GitHub Actions, and explore webhooks.  
  
##Part 1: Dockerize it  
  
(To be submitted for Milestone Participation)  
  
#Documentation  
Running the project locally:  
-First off, I created a separate repository for Project5 using the link provided in Pilot. I cloned this repository onto my local machine and established credentials so that I can push and pull between my machine and GitHub.
-I then installed Docker Desktop onto my local computer. I set it up to be used with WSL2 and Ubuntu, since those are the resources that will be used for this project.  
-To install Docker onto my local Ubuntu image, I followed the guide available at https://dev.to/bartr/install-docker-on-windows-subsystem-for-linux-v2-ubuntu-5dl7 . The commands to setup Docker on the Ubuntu image were pretty much identical, so I simply followed the given commands, skipping the optional ones.  
-To check to make sure Docker was installed and working properly, I ran the command "sudo docker run -it hello-world", and the following was outpu, indicating a successful installation:  
- ![docker installation](https://github.com/WSU-kduncan/cicd-3120-mhayslett16/blob/main/docker-installed.JPG)  
-To install Docker, you must have WSL2 installed onto your Windows machine, which requires Windows 10 build 18917 or higher. Other dependencies include updating the Ubuntu package manager using "sudo apt-get update", as well as installing some other prerequesites that are outlined in the installation guide mentioned and linked above.  
-Building the container image that is used to run the project requires you to create an HTML file with the contents of your website. For this project, I used a basic HTML file that just states that it's running Project5. The web contents should be placed in a "website" folder under the Git repository folder in the local machine. I named this file "index.html".  
-I then created a Dockerfile (I placed this in the "website" folder as well). I used the guide from https://hub.docker.com/_/httpd to create a simple httpd container.  
-I used the guide to build the image as well, using the command "sudo docker build -t my-apache2 ." (please notice the "." because I kept missing it and getting errors.)  
-You can test to make sure your image has been created by running "sudo docker images" and checking for the name of the image you attempted to build in the previous command.  
-After verifying that the image has been created, you can run it. I used the command "sudo docker run -dit --name my-running-app -p 8080:80 my-apache2". This runs the container as a process called "my-running-app", and pulls from the "my-apache2" image to run a local connection over port 8080.  
-You can view the project by opening a web browser and typing into the search bar:" localhost:8080 ".  
-And with that, your HTML page should be running on your local network. Here's an example of what mine looks like running on my personal laptop over my home Wi-Fi connection:  
-![Site running locally](https://github.com/WSU-kduncan/cicd-3120-mhayslett16/blob/main/running-site.JPG)
  
  
-***Site content and Dockerfile are available under the "website" folder of this repository***
