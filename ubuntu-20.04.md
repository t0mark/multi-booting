# Ubuntu 20.04

## 무선랜 A3000 mini 드라이버 설치
- 우분투 20.04, 커널 5.15.0-139-generic 기준
```bash
# 커널 버전 확인
uname -a

git clone https://github.com/RinCat/RTL88x2BU-Linux-Driver
cd RTL88x2BU-Linux-Driver

sudo apt update
sudo apt install git

sudo apt update
sudo apt install make

sudo apt update
sudo apt install build-essential

make
sudo make install

# insatll 후 재부팅
```

## ROS1 Noetic 설치
``` bash
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install ros-noetic-desktop-full

echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
sudo rosdep init
rosdep update
```
