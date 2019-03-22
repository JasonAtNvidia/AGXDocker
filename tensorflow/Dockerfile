# jetson-agx/tensorflow:jetpack-$BUILD_VERSION-bionic

ARG REPOSITORY
ARG TAG
FROM ${REPOSITORY}:${TAG}
LABEL maintainer "Jason Tichy"

# args
ARG BUILD_VERSION
ARG USER
ARG UID

# setup environment variables
ENV container docker
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

# set the locale
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

# install packages
RUN apt-get update \
    && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs) main restricted \n\
deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-updates main restricted \n\
deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse \n\
deb-src http://security.ubuntu.com/ubuntu $(lsb_release -cs)-security main restricted" \
    > /etc/apt/sources.list.d/official-source-repositories.list

# install regular tools
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TERM=linux apt-get install --no-install-recommends -q -y \
    apt-transport-https \
    apt-utils \
    bash-completion \
    build-essential \
    bzip2 \
    ca-certificates \
    clang \
    clang-format \
    cmake \
    cmake-curses-gui \
    curl \
    gconf2 \
    gconf-service \
    gdb \
    git-core \
    git-gui \
    gvfs-bin \
    inetutils-ping \
    llvm \
    llvm-dev \
    nano \
    net-tools \
    pkg-config \
    shared-mime-info \
    software-properties-common \
    sudo \
    tzdata \
    unzip \
    wget \
    libhdf5-dev \
    python3-dev \
    python3-pip \
    python3-numpy \
    python3-setuptools \
    python3-h5py \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*


# install packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TERM=linux apt-get install --no-install-recommends -q -y \
    mesa-utils \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# create user
ENV HOME /home/$USER
RUN adduser $USER --uid $UID --disabled-password --gecos "" \
    && usermod -aG audio,video $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# switch to non-root user
USER $USER

# labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="jetson-agx/tensorflow:jetpack-$BUILD_VERSION-bionic"
LABEL org.label-schema.description="NVIDIA Jetson AGX JetPack-$BUILD_VERSION Tensorflow - Ubuntu-18.04."
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="xhost +local:root \
docker run -it \
  --device /dev/nvhost-as-gpu \
  --device /dev/nvhost-ctrl \
  --device /dev/nvhost-ctrl-gpu \
  --device /dev/nvhost-ctxsw-gpu \
  --device /dev/nvhost-dbg-gpu \
  --device /dev/nvhost-gpu \
  --device /dev/nvhost-prof-gpu \
  --device /dev/nvhost-sched-gpu \
  --device /dev/nvhost-tsg-gpu \
  --device /dev/nvmap \
  --device /dev/snd \
  --net=host \
  -v /dev/shm:/dev/shm \
  -v /etc/localtime:/etc/localtime:ro \
  -v /usr/local/cuda/lib64:/usr/local/cuda/lib64 \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
  --rm \
  --name jetson-agx-tf-jetpack-$BUILD_VERSION-bionic \
  jetson-agx/tensorflow:jetpack-$BUILD_VERSION-bionic \
xhost -local:root"

# set the working directory
WORKDIR $HOME

# update .bashrc
RUN echo \
'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu/tegra-egl:/usr/lib/aarch64-linux-gnu:/usr/local/lib:$LD_LIBRARY_PATH\n\
export NO_AT_BRIDGE=1\n\
export PATH=/usr/local/cuda/bin:$PATH\n\
export PS1="${debian_chroot:+($debian_chroot)}\u:\W\$ "' \
    >> $HOME/.bashrc

# Install Tensorflow
RUN if [ "$BUILD_VERSION" = "4.2.0"   ]; then \
      echo "downloading Tensorflow associated with jetpack-$BUILD_VERSION" ; \
      wget -q https://developer.download.nvidia.com/compute/redist/jp/v42/tensorflow-gpu/tensorflow_gpu-1.13.1+nv19.3-cp36-cp36m-linux_aarch64.whl \
      && pip3 install tensorflow_gpu-1.13.1+nv19.3-cp36-cp36m-linux_aarch64.whl ;\
    elif [ "$BUILD_VERSION" = "4.1.1" ]; then \
      echo "error: I need to put something here to fix this" \
      exit 1 ;\
    else \
      echo "error: please specify jetpack version in build.sh" \
      exit 1 ;\
    fi \
    && rm -Rf tensorflow_gpu-1.13.1+nv19.3-cp36-cp36m-linux_aarch64.whl



CMD ["bash"]
