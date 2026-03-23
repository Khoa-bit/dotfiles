# Tell PowerShell to ignore the profile if it is running in a non-interactive session
oh-my-posh init pwsh --config "$HOME\OneDrive - Eurofins ITWW\Documents\PowerShell\OhMyPosh\khoa_theme.omp.json" | Invoke-Expression

# Zoxide that is installed by binaries from Github
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
. "$HOME\local\bin\_zoxide.ps1"

# --------------------------------

# Get directory size in GB and MB, including hidden/system files
function Get-DirSize {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Position = 0)]
        [alias("FullName")]
        [string]$Path = "."
    )

    process {
        $item = Get-Item -Path $Path -Force
        
        # -Force is the key here to see hidden/system files
        $files = Get-ChildItem -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
        
        $sizeBytes = ($files | Measure-Object -Property Length -Sum).Sum

        if ($null -eq $sizeBytes) { $sizeBytes = 0 }

        [PSCustomObject]@{
            Name   = $item.Name
            SizeGB = [math]::Round($sizeBytes / 1GB, 2)
            SizeMB = [math]::Round($sizeBytes / 1MB, 2)
            Path   = $item.FullName
        }
    }
}

# Search command history with fzf
function Invoke-FzfHistory {
    $historyPath = (Get-PSReadLineOption).HistorySavePath
    if (Test-Path $historyPath) {
        # Get history, reverse it so newest is on top, and pass to fzf
        $command = Get-Content $historyPath | Select-Object -Unique | fzf --tac --height 40%
        if ($command) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
        }
    }
}

# Bind to Ctrl+r
Set-PSReadLineKeyHandler -Key "Ctrl+r" -ScriptBlock { Invoke-FzfHistory }