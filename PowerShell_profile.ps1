#Stuff to keep out of public repo
$scriptPaths = @(
    "$HOME\Code\knapp-gainwell-tools\knapp-gainwell-tools.ps1"
)

foreach ($scriptPath in $scriptPaths) {
    if (Test-Path $scriptPath) {
        Write-Host -ForegroundColor blue "Running: $scriptPath"
        Import-Module $scriptPath
    }
}

function cm {
    python ~\Code\dot-files\scripts\clipboard-manipulator.py $args
}

function np {
    param (
        [string]$FilePath
    )

    # Path to the Notepad++ executable
    $NotepadPlusPlusPath = "C:\Program Files\Notepad++\notepad++.exe"

    if (Test-Path $NotepadPlusPlusPath -PathType Leaf) {
        # Check if Notepad++ is installed and the executable exists
        & $NotepadPlusPlusPath $FilePath
    }
    else {
        Write-Host "Notepad++ is not installed or the executable was not found."
    }
}

function Kill-Port{
    param (
        [string]$Port
    )
	$Process = Get-NetTCPConnection | Where-Object { $_.LocalPort -eq $Port }
	if ($Process) {
		Stop-Process -Id $Process.OwningProcess -Force
	}
}

function remove-older-stashes {
    param (
        [int]$Index
    )

    # Get the list of stashes
    $stashes = git stash list

    # Check if there are any stashes
    if ($stashes.Count -eq 0) {
        Write-Output "No stashes found."
        return
    }

    # Remove stashes older than the specified index
    for ($i = $stashes.Count - 1; $i -gt $Index; $i--) {
        git stash drop "stash@{$i}"
    }

    $stashes = git stash list
	$remainingCount = $stashes.Count
	Write-Host -ForegroundColor Blue "$remainingCount stashes remaining" 
}


####################################################################################################
# This function copies a folder (and optionally, its subfolders)
#
# When copying subfolders it calls itself recursively
#
# Requires WebClient object $webClient defined, e.g. $webClient = New-Object System.Net.WebClient
#
# Parameters:
#   $source      - The url of folder to copy, with trailing /, e.g. http://website/folder/structure/
#   $destination - The folder to copy $source to, with trailing \ e.g. D:\CopyOfStructure\
#   $recursive   - True if subfolders of $source are also to be copied or False to ignore subfolders
#   Return       - None
####################################################################################################
$webClient = New-Object System.Net.WebClient
Function Copy-Folder([string]$source, [string]$destination, [bool]$recursive) {
    if (!$(Test-Path($destination))) {
        New-Item $destination -type directory -Force
    }

    # Get the file list from the web page
    $webString = $webClient.DownloadString($source)
    $lines = [Regex]::Split($webString, "<br>")
    # Parse each line, looking for files and folders
    foreach ($line in $lines) {
        if ($line.ToUpper().Contains("HREF")) {
            # File or Folder
            if (!$line.ToUpper().Contains("[TO PARENT DIRECTORY]")) {
                # Not Parent Folder entry
                $items =[Regex]::Split($line, """")
                $items = [Regex]::Split($items[2], "(>|<)")
                $item = $items[2]
                if ($line.ToLower().Contains("&lt;dir&gt")) {
                    # Folder
                    if ($recursive) {
                        # Subfolder copy required
                        Copy-Folder "$source$item/" "$destination$item/" $recursive
                    } else {
                        # Subfolder copy not required
                    }
                } else {
                    # File
                    $webClient.DownloadFile("$source$item", "$destination$item")
                }
            }
        }
    }
}


# # fancy prompt
Import-Module -Name posh-git
oh-my-posh init pwsh --config "C:\Users\cknapp\Code\dot-files\hotstick.ck.omp.json"| Invoke-Expression

$env:POSH_GIT_ENABLED = $true