param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$IP
)

$apiKey = "IJKnmPQNuqofLleJZD40A9MbItNMIDvK"
$url = 'https://api.shodan.io/shodan/host/' + $IP + '?key=' + $apiKey


try {
    $response = Invoke-RestMethod -Uri $url

    Write-Host "IP: $($response.ip_str)"
    Write-Host "Organizacja: $($response.org)"
    Write-Host "Kraj: $($response.country_name)"
    Write-Host "Miasto: $($response.city)"
    Write-Host ""
    Write-Host "Otwarte porty:"

    $response.data | ForEach-Object {
        Write-Host "Port: $($_.port)"
    }
}
catch {
    Write-Host "Blad: Nie udalo sie pobrac danych. Sprawdz IP lub klucz API."
}
