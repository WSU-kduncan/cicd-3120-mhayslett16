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
  
    

Notes:  
- Because I was working with my local Ubuntu setup, I had to connect my GitHub repo and intall Docker onto the EC2 instance. Steps to do this were explained in and can be referenced to in Part 1's documentation.
  
Container Restart Script:  
- The container restart script, "pull-restart.sh" is a bash script that contains the commands to stop the image (cheese in this case) and remove unrunning images on the system. It will then pull the latest version of the image from Dockerhub and run it under the name "cheese".
- The script can be run using the command "./pull-restart.sh".
- I tested to make sure this worked by adding a new line to the index.html file and pushing it to GitHub. Once the workflow on GitHub was finished, I came back to my Ubuntu instance and ran the pull-restart.sh script. By going to localhost:8080, I could see that the changes were successfully implemented locally.


## VERY IMPORTANT NOTE:
***It was around this time that I made a major error-  
Picture it: My AWS instance was almost at the 4 hour mark so I went to restart it and accidentally reset my AWS lab instead. This is a very terrible thing, especially because the webhook was listening and I was nearly there! I thought I could save it but ended up just watching the AWS lab page spiral in an endless loop of false hope. So, due to time constraints, I'm going to focus on good documentation on what I was able to get done and thank past me for completing the milestones to make up for lost points. Had this happened earlier in the week I may have rebuilt the whole thing and tried to catch up but I am sad and tired so I'm going to take the L on this one. Sorry I'm a failure :')***
  
Webhook Task Definition File:  
- First you want to install webhook using sudo apt-get install webhook.  
- The Webhook definition file is a simple file where we tell our webhook what to do when it's run.  
- Mine sadly didn't make it to GitHub before the incident, so I recreated a new json file locally.  
- This particular definition file is called redeploy-webhook. It is written to run the pull-restart.sh script we made previously in this section.  
- Since the command-working-directory we specified in this file was "/var/webhook", you'll want to make a /var/webhook directory and run the command "webhook -hooks redeploy.json -verbose to see if you were successful. If you are. it will tell you that it's serving hooks on http://0.0.0.0:9000/hooks/{id}.   

Setting up a webhook on the server  
- This is where I was when I made the biggest oopsie of my whole college career, so it's not as detailed as I would like.  
- Issues with outbound rules prevented us from communicating over port 9000, so first go to AWS and set a new outbound rule to allow it.  
- The version of webhook we had installed doesn't have the things we need to run this project properly, so we have to install webhooks with Go. To do this use "wget https://go.dev/dl/go1.18.linux-amd64.tar.gz". This will add a compressed file to your directory. Decompress it with "sudo tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz".
- You'll then want to add /usr/local/go/bin to the PATH env variable using "export PATH=$PATH:/usr/local/go/bin".  
- You can make sure go is successfully downloaded by using "go versio
n".
- Next we'll install a special version of webhook that will work with Go. DO this with the command "go install github.com/adnanh/webhook@latest".  
- Next, to make webhook run as a service, we'll need to make another file using the command "sudo touch /etc/systemd/system/webhook.service". Use vim to edit this file to look like the webhook-service-file I included (But don't include the comments).  
- Then you can enable the service by using "sudo systemctl enable webhook.service". No issues occurred on my attempt so I could start the service using "sudo systemctl start webhook.service".  
-Before I started mine I ran the command "/home/ubuntu/go/bin/webhook -hooks redeploy.json -verbose" to view the logs, and went to "35.170.220.160:9000/hooks/redeploy" to test to see if my webhook was listening on the port. It returned an error message since this wasn't the full address, but it meant the hook was at least listening.  
- Going to "35.170.220.160:9000/hooks/redeploy-webhook", which is the correct URL, gave us a blank page.  
- With more configuration we could've had this page display our html file, but that was as far as I got before things went bad.  
  
Setting up a notifier in GitHub or Dockerhub  
- I didn't get this far :')
  
  
# Part 4: Diagramming
- Here is my lovely workflow diagram for the parts of the project I was able to complete:  
![Workflow Diagram](https://github.com/WSU-kduncan/cicd-3120-mhayslett16/blob/main/Workflow%20diagram.jpg)  
