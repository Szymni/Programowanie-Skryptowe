#Ścieżki
$sourcePath = "C:\Users\szymk\Desktop\Programowanie\skyptowe"
$destinationPath = "C:\Users\szymk\Desktop\Programowanie\skryptowe\monitoring"

#Utwórz folder docelowy jeśli nie istnieje
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath | Out-Null
    Write-Host "Utworzono folder docelowy: $destinationPath"
}

Write-Host "Monitorowanie folderu: $sourcePath"
Write-Host "Naciśnij Ctrl+C aby zakończyć.`n"

#Lista wcześniej wykrytych plików
$przetworzonePliki = @{}

while ($true) {
    $pliki = Get-ChildItem -Path $sourcePath -Filter *.txt -File

    foreach ($plik in $pliki) {
        if (-not $przetworzonePliki.ContainsKey($plik.Name)) {
            $destinationFile = Join-Path $destinationPath $plik.Name

            try {
                Move-Item -Path $plik.FullName -Destination $destinationFile -Force
                Write-Host "Przeniesiono nowy plik: $($plik.Name)"
                $przetworzonePliki[$plik.Name] = $true
            } catch {
                Write-Host "Błąd przenoszenia pliku ${plik.Name}: $_"
            }
        }
    }

    Start-Sleep -Seconds 5
}

