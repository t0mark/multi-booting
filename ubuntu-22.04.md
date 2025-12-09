# Ubuntu 22.04

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

## 키보드 Fn 설정
``` bash
echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u
sudo reboot
```