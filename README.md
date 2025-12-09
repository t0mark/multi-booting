# multi-booting
Ubuntu &amp; Windows

## 호스트 설치
```bash
sudo apt update && sudo apt upgrade -y

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

# codex
sudo npm install -g @openai/codex
```
---

## 컨테이너 설치
``` bash
apt update && apt upgrade -y
apt install curl wget gedit sudo
```