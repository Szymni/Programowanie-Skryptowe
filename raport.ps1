$components = Import-Csv "C:\Users\szymk\Desktop\Programowanie\skyptowe\input_file.csv" ";"

$info = Get-ComputerInfo
$serial = (Get-WmiObject -Class Win32_BIOS).SerialNumber
$cpuName = (Get-WmiObject Win32_Processor).Name
$ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB
$ramFormatted = "{0:N0} GB" -f $ram

foreach ($item in $components) {
    if ($item.GenerateReport -eq 'True') {
        switch ($item.Component) {
            "Computername"   { Write-Host "Computername: $env:COMPUTERNAME" }
            "Manufacturer"   { Write-Host "Manufacturer: $($info.CsManufacturer)" }
            "Model"          { Write-Host "Model: $($info.CsModel)" }
            "SerialNumber"   { Write-Host "SerialNumber: $serial" }
            "CpuName"        { Write-Host "CpuName: $cpuName" }
            "RAM"            { Write-Host "RAM: $ramFormatted" }
            default          { Write-Host "$($item.Component): Nieobsługiwany komponent" }
        }
    }
}