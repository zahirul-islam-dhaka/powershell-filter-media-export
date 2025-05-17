<#
.SYNOPSIS
    Recursively filters files with specific extensions and exports details to CSV.

.AUTHOR
    Md. Zahirul Islam
    Email: zahirul.islam.spa@gmail.com
    Cell: +8801711792629
#>

$root = Get-Location

# Define the allowed extensions
$allowedExtensions = @(".m4a", ".mp3", ".amr", ".id-", ".rasel", ".zannat")

# Filter and export
Get-ChildItem -Recurse -File |
Where-Object { $allowedExtensions -contains $_.Extension.ToLower() } |
Select-Object @{Name="Enumerator"; Expression={
    ($_.FullName.Replace($root.Path + "\", "") -split '\\')[0]
}},
@{Name="FileName"; Expression={$_.Name}},
@{Name="Extension"; Expression={$_.Extension}},
@{Name="trans_subdate"; Expression={$_.LastWriteTime.ToString("M/d/yyyy")}} |
Export-Csv "filtered_file_details.csv" -NoTypeInformation -Encoding UTF8
