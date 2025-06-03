
$filePath = Read-Host "Podaj pełną ścieżkę do pliku który chcesz sprawdzić: "
$apiKey = "763fc2f0dc2d583cc0a6244f5f93296ae7093e5778c35792eac26306fb9dff54"

#Obliczanie hasha
$sha256 = $sha256 = Get-FileHash -Path $filePath -Algorithm SHA256 | Select-Object -ExpandProperty Hash
Write-Host "SHA256: $sha256"

#Zapytanie do VirusTotal
$vtUrl = "https://www.virustotal.com/api/v3/files/$sha256"
$headers = @{
    "x-apikey" = $apiKey
}

#Interpretowanie wyników
try {
    $response = $response = Invoke-RestMethod -Uri $vtUrl -Headers $headers -Method Get
    $malicious = $response.data.attributes.last_analysis_stats.malicious
    $harmless = $response.data.attributes.last_analysis_stats.harmless

    if ($malicious -eq 0) {
        Write-Host "Plik jest bezpieczny"
    } else {
        Write-Host "Plik może zawierać złośliwe oprogramowania"
    }
} catch {
    Write-Host "Plik nie znajduje się w bazie Virus Total"
}