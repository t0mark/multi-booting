@echo off
title 한국 시간 동기화 도구
echo ===================================
echo    한국 표준시(KST) 동기화 도구
echo ===================================
echo.

echo 1단계: 관리자 권한 확인 중...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 이 스크립트는 관리자 권한이 필요합니다.
    echo 파일을 마우스 우클릭 후 '관리자 권한으로 실행'을 선택해주세요.
    pause
    exit
)

echo 2단계: 시간대를 한국 표준시(KST)로 설정 중...
tzutil /s "Korea Standard Time"
if %errorlevel% neq 0 (
    echo 시간대 설정에 실패했습니다.
    pause
    exit
)
echo 시간대가 한국 표준시(KST)로 설정되었습니다.

echo 3단계: 인터넷 시간 서버와 동기화 중...
w32tm /resync /force
if %errorlevel% neq 0 (
    echo Windows 시간 서비스를 시작합니다...
    net start w32time
    w32tm /resync /force
)

echo.
echo 동기화가 완료되었습니다!
echo 현재 시간: 
time /t
echo 현재 날짜: 
date /t
echo.
echo 이제 컴퓨터 시간이 한국 표준시로 설정되었습니다.
pause