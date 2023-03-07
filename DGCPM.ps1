$path = Get-Location
$file = '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'
$test = 'test'
$bakPath = Test-Path -Path '..\AppData\Local\Google\Chrome\User Data\Default\Preferences_bak'
$bakfile = '..\AppData\Local\Google\Chrome\User Data\Default\Preferences_bak'

if(tasklist | findstr chrome){
Write-Host "[X] Chrome�� �������Դϴ�" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

if($path -match "Desktop$"){
    Write-Host "[1] ȯ�漳�� ������ �����մϴ�.." -ForegroundColor white -BackgroundColor black
} else {
    Write-Host "[X] ����ȭ�鿡�� ������� �ּ���" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

if(Test-Path -Path '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'){
    $getFile = Get-Content $file
    # ������� ȯ�漳�� ���
    if(!$bakPath)
    {
        Write-Host "[2] ������̴� ȯ�漳���� ���(���ϸ�: Preferences_bak) " -ForegroundColor green -BackgroundColor black
        Copy $file $bakfile
        Start-Sleep -Seconds 2
    }

    Write-Host "[3] ȯ�漳�� ������ �����մϴ�." -ForegroundColor white -BackgroundColor black
    # ȯ�漳�� ���� ������ ���ڸ��� account_tracker_service_last_update �� ��� 

    if(!($getFile.Contains("credentials_enable_"))){
        Write-Host "[3-1-1] �ʱ� �� �����ܰ�" -ForegroundColor yellow -BackgroundColor black
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

        # "default_apps_install_state" ���� ��ġ�� ã�� �� �� ��ġ ������ �� �Ӽ��� ����ִ´�.
        Write-Host "[3-1-2] �ʱ� �� ���� �Ϸ�" -ForegroundColor yellow -BackgroundColor black

        $configFile = Get-Content $file `
        | %{$_ -replace('"default_apps_install_state"', '"credentials_enable_autosignin":false,"credentials_enable_service":false,"default_apps_install_state"')}

    }
    else {
        # ȯ�漳���� �ѹ��̶� ������ ���� ������ ������ ����
        Write-Host "[3-2] �ʱ� �� ������Ʈ ����" -ForegroundColor white -BackgroundColor black
    
        $configFile = Get-Content $file `
        | %{$_ -replace('"credentials_enable_service":true', '"credentials_enable_service":false')}`
        | %{$_ -replace('"credentials_enable_autosignin":true', '"credentials_enable_autosignin":false')} 
    }
    Start-Sleep 1
    # Preferences ���� �����
    Set-Content -Path $file -Value $configFile -Encoding utf8
    Write-Host "[4] Chrome Preferences ���� �Ϸ�" -ForegroundColor white -BackgroundColor black

} else {
    # ũ���� ��ġ���� ����
    Write-Host "[X] Chrome Preferences ������ �������� �ʽ��ϴ�(ũ�� ��ġ�ʿ�)" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}