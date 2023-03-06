<# 
�ش� ��ũ��Ʈ�� �ڵ��ϼ�(��й�ȣ ���� ���� Ȯ��, �ڵ� �α��� ���) ��Ȱ��ȭ�� �������� �����Ͽ���

1) ũ�� ���μ����� �������̸� ���α׷� �ߴ�
2) ����� ����ȭ�鿡�� ����Ǵ��� Ȯ���մϴ�.
3) ũ�� ��������(Preferences)�� C:\Users\[quser]\AppData\Local\Google\Chrome\User Data\Default ��� Ȯ��
4) (�����Ѵٸ�) ȯ�漳�� ������ �ڵ��ϼ� ��� 2���� �ɼ��� ��Ȱ��ȭ ������ ����
    �� credentials_enable_service false
    �� credentials_enable_autosignin false

#>

[string]$path= Get-Location
[string]$file= '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'

#ũ���� ���������� Ȯ���Ѵ�.
if(tasklist | findstr chrome){
    Write-Host "[X] Chrome.exe �� �������Դϴ�. ���μ��� ���� �� �ٽ� �����ϼ���" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

# �ֻ��� ��ο��� ����Ǵ��� Ȯ���Ѵ�
if($path -like "*desktop*"){
    Write-Host "[1] ���α׷��� �����մϴ�" -ForegroundColor green -BackgroundColor black
} else {
    Write-Host "[X] ����ȭ�鿡�� �������ּ���.." -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}

#������ �����ϴ��� Ȯ���Ѵ�
if(Test-Path -Path '..\AppData\Local\Google\Chrome\User Data\Default\Preferences'){
    Write-Host "[2] ȯ�漳�� ������ ã�ҽ��ϴ�.."  -ForegroundColor green -BackgroundColor black
    
    $configFile = Get-Content $file `
    | %{$_ -replace('"credentials_enable_service":true', '"credentials_enable_service":false')} `
    | %{$_ -replace('"credentials_enable_autosignin":true', '"credentials_enable_autosignin":false')} 

    Set-Content -Path $file -Value $configFile -Encoding utf8
    Write-Host "[3] ȯ�漳�� ���� ������ �Ϸ�Ǿ����ϴ�. Chrome ������ Ȯ���ϼ���"  -ForegroundColor green -BackgroundColor black
    Exit
} else {
    Write-Host "[X] Preferences ������ �������� �ʽ��ϴ�" -ForegroundColor red -BackgroundColor black
    Start-Sleep -Seconds 2
    Exit
}
