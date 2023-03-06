해당 스크립트는 자동완성(비밀번호 저장 여부 확인, 자동 로그인 기능) 비활성화를 목적으로 제작하였음
1) 크롬 프로세스가 동작중이면 프로그램 중단
2) 사용자 바탕화면에서 실행되는지 확인합니다.
3) 크롬 설정파일(Preferences)이 C:\Users\[quser]\AppData\Local\Google\Chrome\User Data\Default 경로 확인
4) (존재한다면) 환경설정 파일의 자동완성 기능 2가지 옵션을 비활성화 값으로 저장
    → credentials_enable_service false
    → credentials_enable_autosignin false