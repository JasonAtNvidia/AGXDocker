# AGX-Docker

AGX-Docker is a bash script that enables ***nvidia-docker***-like functionality on the NVIDIA AGX Product line.  This bash script has been developed for use with Jetpack 4.2.0 using Ubuntu 18.04 with all of the NVIDIA software packages installed.

Special Thanks to Elvis Dowson, whose work in the devtalk forum privided the inspiration for this project. [link](https://devtalk.nvidia.com/default/topic/1043951/jetson-agx-xavier/docker-gpu-acceleration-on-jetson-agx-for-ubuntu-18-04-image/post/5296647/#5296647)

# Install Directions

First, clone the repository on the AGX Product
```sh
$ git clone https://github.com/JasonAtNvidia/AGXDocker
```
Then move the ```agx-docker``` file into /usr/local/bin
```sh
$ cd AGXDocker
$ sudo mv agx-docker /usr/local/bin/
$ sudo chmod +x /usr/local/bin/agx-docker
```

You may also find it easier to execute docker commands without sudo privileges, do so by adding your user name into the docker group.
```sh
$ sudo usermod -aG docker $USER
```
This will require a restart to take effect.

# Usage instructions
Use ```agx-docker``` just as you would the regular docker command.  The bash script overloads the ```docker run``` command to map libraries and devices where they need to be to properly execute inside of the AGX product.

There are also several folders containing Dockerfiles for specific libraries to use as an example.  You can build each Dockerfile simply by executing the ```build.sh``` file located in each's respective folder.



License
----
MIT

**Free Software, provided without guarantee**