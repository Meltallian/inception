FROM debian:11

#&& apt-get upgrade
RUN apt-get update && apt-get install -y nginx 

#In the Dockerfile, the COPY instruction is used to copy files or directories 
#from the host machine (where the Docker build command is run) into the Docker image.
COPY default /etc/nginx/sites-available/

# Create an entrypoint script to wait for wp-php and then start Nginx
#COPY entrypoint.sh /usr/local/bin/entrypoint.sh
#RUN chmod +x /usr/local/bin/entrypoint.sh

# Use the entrypoint script as the container's entry point
#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

#This argument tells Nginx to run in the foreground (i.e., not as a daemon). 
#Running in the foreground is necessary for Docker containers because if the main process 
#(Nginx in this case) exits, the container will stop.
CMD ["nginx", "-g", "daemon off;"]