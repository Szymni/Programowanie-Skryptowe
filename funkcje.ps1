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
Aktualna-Data
Wersja-Systemu
Uzytkownik
Adres-IP