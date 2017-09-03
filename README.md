## Docker for Gazee

This is a docker container for the WebApp Comic Reader [Gazee](https://github.com/hubbcaps/gazee).

## Docker Container

[Dockerfile](./Dockerfile) associated in this repository allows you to containerize the service. It installs all dependencies and required python packages automatically. You can find the docker image [here in docker hub](https://hub.docker.com/r/hubcapps/gazee/).

**Step 1A: Pull Docker image for Gazee**

You can pull the image directly from docker hub using the following commands: 
 
 `docker pull hubcapps/gazee`

**Step 1B: Build Docker image for Gazee**

Alternatively you can build your own docker image locally by entering in the following commands: 

```bash
git clone https://github.com/hubbcaps/docker-gazee.git
cd /docker-gazee
docker build -t hubcapps/gazee .
```
**Step 2: Run docker container**

To run the container, enter the following command on your docker host: 

```
docker run -dt \
--name=gazee \
-v ${local-comics-dir}:/comics \
-v ${local-gazee-dir}:/config \ 
-v ${local-mylarDB-dir}:/mylar \
-v ${local-certs-dir}:/certs \
-p 4242:4242 \
hubcapps/gazee
```
**Note:** 

`-v ${local-comics-dir}:/comics` is a volume mount from your local host directory where you have stored your comicbook files `${local-comics-dir}` to the `/comics` directory within the container. 

`-v ${local-gazee-dir}:/config` is a volume mount from your local host directory to expose the configs inside the docker container to your host file system for easy log parsing, app configuration and backup ability.`

`-v ${local-mylarDB-dir}:/mylar` **Optional Flag** is a volume mount from your local host directory where you have stored your mylar db `${local-mylarDB-dir}` to the `/mylar` directory within the container.

`-v ${local-certs-dir}:/certs` **Optional Flag** is a volume mount from your local host directory where you have stored your server certificate `${local-certs-dir}` to the `/certs` directory within the container.

**Step 3: Logon to Gazee's Web UI**

You can use the above volume mounts to configure the settings of the app and dictate where to find you comic library, Mylar DB, and certificates.

Go to **http://your-ip:4242**
  
  Default username and password for the web interface:
  
  * **Username:** `admin`
  * **Password:** `gazee`
