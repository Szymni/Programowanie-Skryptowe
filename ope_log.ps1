$login = Read-Host "Podaj nazwe uzytkownika: " 
$haslo_maska = Read-Host "Podaj haslo: " -AsSecureString

$haslo = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($haslo_maska)
)


if ($login -eq "admin" -and $haslo -eq "password") {
    Write-Host "Poprawne logowanie!"
} else {
    Write-Host "Blad logowania"
}