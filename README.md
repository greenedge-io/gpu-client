# FoG (A FoG of GPUs) GPU Client

greenedge.io website: http://greenedge.io/

FoG site: https://fog.greenedge.io

## Prerequisites

### Install nvidia-docker

Please see: https://github.com/NVIDIA/nvidia-docker

On Ubuntu OS:

1. Please update your Nvidia drivers. Download and install the latest drivers from: http://www.nvidia.com/Download/index.aspx.

2. Uninstall `docker.io` if you already have it installed.
```
sudo apt-get remove docker docker-engine docker.io
```

3. Install `docker-ce`. You can follow the steps described here: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository. In summary:
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
```

4. Install `nvidia-docker`:
```
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i nvidia-docker_1.0.1-1_amd64.deb
```

To test:
```
nvidia-docker run --rm nvidia/cuda nvidia-smi
```

### Install other software

Install `screen`:
```
sudo apt-get intall screen
```

## Setup and run FoG GPU client

1. Clone our git repository
```
git clone https://github.com/greenedge-io/gpu-client.git
```

2. Go to our website and register, either with a new account or using your Google account. Remember your email address and copy your secret key from the Account page.

3. Start the client. You will be asked for your email address and the secret only the first time you start the client. These values will be saved in `.config`.
```
./start-client.sh
```

4. You can monitor the client by attaching to the screen session:
```
screen -r <id>
```
The id of this screen session is returned by the start script. If you are already attached to the screen after running `start-client.sh`, you can detach by pressing `Ctrl+A` followed by `Ctrl+D`.

5. To stop the client:
```
./stop-client.sh
```

### Thank you for joining FoG community! 
