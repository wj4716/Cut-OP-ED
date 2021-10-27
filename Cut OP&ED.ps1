$OP=Read-Host -Prompt '输入片头长度（秒）'
$ED=Read-Host -Prompt '输入片尾长度（秒）'
md Output
Get-ChildItem -Path (Get-Location).path | ForEach {
    $StrLength = (ffprobe -i $_.Name -show_entries format=duration -v quiet -of csv="p=0") | Out-String
    $IntLength = [int]$StrLength
    $Position = $IntLength - $ED
    ffmpeg -ss $OP -to $Position -i $_.Name -c copy .\Output\$($_.Name) -y
}
pause
