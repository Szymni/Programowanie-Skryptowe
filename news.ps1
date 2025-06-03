param (
    [Parameter(Mandatory=$true)]
    [string]$Temat
)

$apiKey = "69b430e1071947bd9b068d6baf8adc35"
$url = "https://newsapi.org/v2/everything?q=$Temat&pageSize=5&language=pl&apiKey=$apiKey"

$response = Invoke-RestMethod -Uri $url

$response.articles | ForEach-Object {
    Write-Host "`nTytuł: $($_.title)"
    Write-Host "Źródło: $($_.source.name)"
    Write-Host "Link: $($_.url)"
    Write-Host "Data: $($_.publishedAt)"
}
