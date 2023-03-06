<# 
해당 스크립트는 자동완성(비밀번호 저장 여부 확인, 자동 로그인 기능) 비활성화를 목적으로 제작하였음

1) 크롬 프로세스가 동작중이면 프로그램 중단
2) 사용자 바탕화면에서 실행되는지 확인합니다.
3) 크롬 설정파일(Preferences)이 C:\Users\[quser]\AppData\Local\Google\Chrome\User Data\Default 경로 확인
4) (존재한다면) 환경설정 파일의 자동완성 기능 2가지 옵션을 비활성화 값으로 저장
    → credentials_enable_service false
    → credentials_enable_autosignin false

#>

[string]$path= Get-Location
[string]$file= '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'

#크롬이 실행중인지 확인한다.
if(tasklist | findstr chrome){
    Write-Host "[X] Chrome.exe 가 실행중입니다. 프로세스 종료 후 다시 시작하세요" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

# 최상위 경로에서 실행되는지 확인한다
if($path -like "*desktop*"){
    Write-Host "[1] 프로그램을 시작합니다" -ForegroundColor green -BackgroundColor black
} else {
    Write-Host "[X] 바탕화면에서 실행해주세요.." -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

#파일이 존재하는지 확인한다
if(Test-Path -Path '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'){
    Write-Host "[2] 환경설정 파일을 찾았습니다.."  -ForegroundColor green -BackgroundColor black
    
    $configFile = Get-Content $file `
    | %{$_ -replace('"credentials_enable_service":true', '"credentials_enable_service":false')} `
    | %{$_ -replace('"credentials_enable_autosignin":true', '"credentials_enable_autosignin":false')} 

    Set-Content -Path $file -Value $configFile -Encoding utf8
    Write-Host "[3] 환경설정 파일 수정이 완료되었습니다. Chrome 설정을 확인하세요"  -ForegroundColor green -BackgroundColor black
    Exit
} else {
    Write-Host "[X] Preferences 파일이 존재하지 않습니다" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}
