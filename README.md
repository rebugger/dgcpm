# DGCPM 
### Disable Google Chrome Password Manager

사용자 PC의 브라우저 보안성을 강화하기 위해 **자동완성 (비밀번호 저장 여부 확인, 자동 로그인)기능** 을 비활성화 하기 위한 파워쉘 스크립트이다.

스크립트 자세한 설명은 [rebugger.log](https://velog.io/@rebugger/How-to-Disable-Google-Chrome-Password-Manager) 개인 블로그 확인

***
### 스크립트 실행
```powershell
Powershell.exe dgcpm.ps1
```

### 스크립트(ps1 확장자) 실행 안되는 경우
```
1) powershell.exe 관리자 권한으로 실행
2) Set-ExecutionPolicy Unrestricted 
    → Y 입력
3) 파일 우클릭
    → Powershell 에서 실행 클릭
```
### 작동방식
```
1. Web Browser 실행여부 확인
2. 스크립트 실행 경로 확인(바탕화면) 
3. 브라우저 환경설정 파일 확인
    → (없으면) 
        1) 크롬 브라우저 설치 
4. 기존 환경설정 파일 백업
    → Preferneces_bak 파일로 복사
    
5. 환경설정 값 확인(특정 속성값 확인 "credentials_enable_")
    → (없으면) 
        1) 브라우저 강제 실행 
        2) 환경설정 페이지 진입
        3) 페이지 닫기
        4) 환경설정 파일 속성 값 치환

        [!] 브라우저 창을 강제로 닫으면 안됨( 환경설정 파일 업데이트를 위해 10초 후 자동 닫힘)
    
    → (있으면) 
        1) 환경설정 파일 속성 값 치환
    
6. 치환 값 환경설정 파일에 저장
7. 완료
```

#### ※ 주의사항
- 반드시 바탕화면에서 스크립트를 동작할 것
- 크롬 브라우저를 모두 끈 상태에서 동작시킬 것
- 크롬 설정파일(Preferences) 파일 백업할 것 (스크립트 내 백업기능이 존재하나 한번 더 점검)
- 실행 중간에 열리는 브라우저 새창을 강제로 끄지말 것(환경설정 업데이트를 위한 작업)
