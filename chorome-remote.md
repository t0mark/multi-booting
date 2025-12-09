# Chrome 원격 데스크톱
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