# Docker for Gazee

This is a docker image for the WebApp Comic Reader [Gazee](https://github.com/hubbcaps/gazee). 

It is a modified version of the [author's Docker image](https://github.com/hubbcaps/docker-gazee) that removes the linuxserver.io base, as they don't use automated builds with public Dockerfiles. Instead, it uses a plain python-alpine base. Below is a slightly modified version of the original readme.

-----

## Docker Container

Dockerfile associated in this repository allows you to containerize the service. It installs all dependencies and required python packages automatically. You can find the docker image [here in docker hub](https://hub.docker.com/r/andreipoe/gazee/).

**Step 1A: Build Docker image for Gazee locally (recommended)**

You can build your own Docker image locally by cloning this repository and running the following commands: 

```bash
git clone https://github.com/andreipoe/docker-gazee.git
cd docker-gazee
docker build -t andreipoe/gazee .
```

**Step 1B: Pull Docker image for Gazee**

Alternatively, you can pull the image directly from DockerHub: 
 
```
docker pull andreipoe/gazee
```

**Step 2: Run docker container**

To run the container:

```
docker run -d --restart-always --name=gazee \
    -v ${local-comics-dir}:/comics \
    -v ${local-gazee-dir}:/config \ 
    -v ${local-mylarDB-dir}:/mylar \
    -v ${local-certs-dir}:/certs \
    -e PUID=${local UID}
    -e PGID=${local GID}
    -p 4242:4242 \
    andreipoe/gazee
```
**Note:** 

`-v ${local-comics-dir}:/comics` is a volume mount from your local host directory where you have stored your comicbook files `${local-comics-dir}` to the `/comics` directory within the container. 

`-v ${local-gazee-dir}:/config` is a volume mount from your local host directory to expose the configs inside the docker container to your host file system for easy log parsing, app configuration and backup ability.`

`-v ${local-mylarDB-dir}:/mylar` **Optional Flag** is a volume mount from your local host directory where you have stored your mylar db `${local-mylarDB-dir}` to the `/mylar` directory within the container.

`-v ${local-certs-dir}:/certs` **Optional Flag** is a volume mount from your local host directory where you have stored your server certificate `${local-certs-dir}` to the `/certs` directory within the container.

`-e PUID/PGID:${local UID/GID}` is a flag for setting the user id and group id of the user within the container running Gazee to match the local user that owns the mounted volumes above. This assures that the whole app 'Just Works' and that there will be no permission issues when attempting to write gazee's configs and logs, or when attempting to scan your library.

**Step 3: Logon to Gazee's Web UI**

You can use the above volume mounts to configure the settings of the app and dictate where to find you comic library, Mylar DB, and certificates.

Go to **http://your-ip:4242**
  
  Default username and password for the web interface:
  
  * **Username:** `admin`
  * **Password:** `gazee`

It is a very good idea to set up a reverse proxy with SSL in front of this Gazee container.

