$path = Get-Location
$file = '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'
$test = 'test'
$bakPath = Test-Path -Path '..\AppData\Local\Google\Chrome\User Data\Default\Preferences_bak'
$bakfile = '..\AppData\Local\Google\Chrome\User Data\Default\Preferences_bak'

if(tasklist | findstr chrome){
Write-Host "[X] Chrome이 실행중입니다" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

if($path -match "Desktop$"){
    Write-Host "[1] 환경설정 변경을 시작합니다.." -ForegroundColor white -BackgroundColor black
} else {
    Write-Host "[X] 바탕화면에서 재실행해 주세요" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

if(Test-Path -Path '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'){
    $getFile = Get-Content $file
    # 사용중인 환경설정 백업
    if(!$bakPath)
    {
        Write-Host "[2] 사용중이던 환경설정을 백업(파일명: Preferences_bak) " -ForegroundColor green -BackgroundColor black
        Copy $file $bakfile
        Start-Sleep -Seconds 2
    }

    Write-Host "[3] 환경설정 파일을 변경합니다." -ForegroundColor white -BackgroundColor black
    # 환경설정 값이 있으나 앞자리가 account_tracker_service_last_update 인 경우 

    if(!($getFile.Contains("credentials_enable_"))){
        Write-Host "[3-1-1] 초기 값 생성단계" -ForegroundColor yellow -BackgroundColor black
        Start-Process 'Chrome'
        Start-Sleep 1
        $wshell = New-Object -ComObject wscript.shell;
        $wshell.AppActivate("$proc")
        Start-Sleep 1
        $wshell.SendKeys('chrome://settings/')
        Start-Sleep 1
        $wshell.SendKeys("{ENTER}")
        Start-Sleep 10
        Stop-Process -Name 'Chrome'
        Start-Sleep 1

        # "default_apps_install_state" 값의 위치를 찾은 후 그 위치 앞으로 두 속성을 집어넣는다.
        Write-Host "[3-1-2] 초기 값 생성 완료" -ForegroundColor yellow -BackgroundColor black

        $configFile = Get-Content $file `
        | %{$_ -replace('"default_apps_install_state"', '"credentials_enable_autosignin":false,"credentials_enable_service":false,"default_apps_install_state"')}

    }
    else {
        # 환경설정을 한번이라도 진행한 적이 있으면 수정만 진행
        Write-Host "[3-2] 초기 값 업데이트 진행" -ForegroundColor white -BackgroundColor black
    
        $configFile = Get-Content $file `
        | %{$_ -replace('"credentials_enable_service":true', '"credentials_enable_service":false')}`
        | %{$_ -replace('"credentials_enable_autosignin":true', '"credentials_enable_autosignin":false')} 
    }
    Start-Sleep 1
    # Preferences 파일 덮어쓰기
    Set-Content -Path $file -Value $configFile -Encoding utf8
    Write-Host "[4] Chrome Preferences 변경 완료" -ForegroundColor white -BackgroundColor black

} else {
    # 크롬이 설치되지 않음
    Write-Host "[X] Chrome Preferences 파일이 존재하지 않습니다(크롬 설치필요)" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}