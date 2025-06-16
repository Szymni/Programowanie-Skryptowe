$komputer = $Env:COMPUTERNAME
 
Function Aktualna-Data {
    Write-Host "Aktualna data na $komputer to: $(Get-Date)"
}

Function Wersja-Systemu {
    $nazwa = (Get-ComputerInfo).OsName
    $wersja = (Get-ComputerInfo).OsVersion
    Write-Host "Aktualna nazwa i wersja systemu na $komputer to: $nazwa, $wersja"
}

Function Uzytkownik {
    $user = $Env:USERNAME
    Write-Host "Aktualny użytkownik na $komputer to: $user"
}

function Adres-IP {
    $ip = (Test-Connection -ComputerName $env:COMPUTERNAME -Count 1).IPV4Address.IPAddressToString
    Write-Host "Adres IP na $komputer to $ip"
}

function RAM-Info {
    $mem = Get-CimInstance Win32_OperatingSystem
    $total = [math]::Round($mem.TotalVisibleMemorySize / 1MB, 2)
    Write-Output "Dostępna pamięć RAM: $total GB"
}

function Disk-Usage {
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
    $size = [math]::Round($disk.Size / 1GB, 2)
    $free = [math]::Round($disk.FreeSpace / 1GB, 2)
    $used = [math]::Round($size - $free, 2)
    Write-Output "Dysk C: zużyte $used GB z $size GB"
}

function GEt-MAC {
    $mac = Get-NetAdapter | Where-Object { $_.Status -eq 'Up'} | Select-Object -First 1 -ExpandProperty MacAddress
    Write-Output "Adres MAC: $mac"
}

function Host-Name {
  Write-Output "Nazwa hosta: $($env:COMPUTERNAME)"
}

Aktualna-Data
Wersja-Systemu
Uzytkownik
Adres-IP
RAM-Info
Disk-Usage
GEt-MAC
Host-Name