# multi-booting
Ubuntu &amp; Windows

## 기타
```bash
sudo apt update
sudo apt upgrade -y

# Chrome
sudo apt install -y wget
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# 우분투 -> 윈도우
# 실행 권한 부여, 한 번만 설정
sudo chmod +x windows.sh
sudo ./windows.sh

# Terminator
sudo apt-get update
sudo apt-get install terminator -y

# VScode
sudo apt update
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code

# gemini-cli
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g @google/gemini-cli

# claude code
sudo npm install -g @anthropic-ai/claude-code
```

---
## Chrome 원격 데스크톱
- 확장 프로그램 $\to$ Chrome remote Desktop

### App 설치
- SSH를 통해 설정 $\to$ 다음 $\to$ Debian Linux 링크 클릭
``` bash
sudo apt update
sudo apt --fix-broken install
sudo dpkg -i ~/Downloads/chrome-remote-desktop_current_amd64.deb
```

### 검정 화면 오류 (예방)
``` bash
# 디스플레이 확인
echo $DISPLAY # 출력 :0 예상
# 파일 수정
sudo gedit /opt/google/chrome-remote-desktop/chrome-remote-desktop
```

- 파일 수정
``` python
# 수정 전 (line 112)
FIRST_X_DISPLAY_NUMBER = 20
# 수정 후
FIRST_X_DISPLAY_NUMBER = 0 # echo $DISPLAY 출력 결과


# 수정 전 (line 779 ~ 794)
  def launch_session(self, server_args, backoff_time):
    """Launches process required for session and records the backoff time
    for inhibitors so that process restarts are not attempted again until
    that time has passed."""
    logging.info("Setting up and launching session")
    self._setup_gnubby()
    self._launch_server(server_args)
    if not self._launch_pre_session():
      # If there was no pre-session script, launch the session immediately.
      self.launch_desktop_session()
    self.server_inhibitor.record_started(MINIMUM_PROCESS_LIFETIME,
                                      backoff_time)
    self.session_inhibitor.record_started(MINIMUM_PROCESS_LIFETIME,
                                     backoff_time)
# 수정 후
  def launch_session(self, server_args, backoff_time):
    """Launches process required for session and records the backoff time
    for inhibitors so that process restarts are not attempted again until
    that time has passed."""
    logging.info("Setting up and launching session")
    self._setup_gnubby()
    display = self.get_unused_display_number()
    self.child_env["DISPLAY"] = ":%d" % display
    # self._launch_server(server_args)
    # if not self._launch_pre_session():
      # If there was no pre-session script, launch the session immediately.
      # self.launch_desktop_session()
    # self.server_inhibitor.record_started(MINIMUM_PROCESS_LIFETIME,
    #                                   backoff_time)
    # self.session_inhibitor.record_started(MINIMUM_PROCESS_LIFETIME,
    #                                  backoff_time)


# 수정 전 (line 1424 ~ 1430)
  def get_unused_display_number():
    """Return a candidate display number for which there is currently no
    X Server lock file"""
    display = FIRST_X_DISPLAY_NUMBER
    while os.path.exists(X_LOCK_FILE_TEMPLATE % display):
      display += 1
    return display
# 수정 후
  def get_unused_display_number():
    """Return a candidate display number for which there is currently no
    X Server lock file"""
    display = FIRST_X_DISPLAY_NUMBER
    # while os.path.exists(X_LOCK_FILE_TEMPLATE % display):
    #   display += 1
    return display
``` 

### 활성화
- 원격 데스크톱 앱 $\to$ 다음 $\to$ 승인 $\to$ 명령어 터미널에 복사 $\to$ 비밀번호 설정
---
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

## NVIDIA 그래픽 드라이버 설치 (노트북)
```bash
sudo apt update && sudo apt upgrade -y

# 최신 NVIDIA 드라이버를 제공하는 PPA 저장소 추가 (RTX 5060 인식을 위해 필수)
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update

sudo gedit /etc/default/grub

# 수정 전
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
# 수정 후
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1"

sudo apt install nvidia-driver-580-open

# 에러 없으면 재부팅
sudo reboot

# 확인
nvidia-smi
```

## ROS 설치
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
