$commandColor = [System.ConsoleColor]::Blue
$failColor = [System.ConsoleColor]::DarkRed
$successColor = [System.ConsoleColor]::DarkCyan
$warningColor = [System.ConsoleColor]::Magenta

#Stuff to keep out of public repo
$scriptPaths = @(
    "$HOME\Code\knapp-gainwell-tools\knapp-gainwell-tools.ps1",
	"$HOME\Code\dot-files\B.ps1",
	"$HOME\Code\dot-files\Line-Endings.ps1"
)

$clockIcons = @( [char]0xf017, [char]0xf017 )

foreach ($scriptPath in $scriptPaths) {
    if (Test-Path $scriptPath) {
        Write-Host -NoNewline -ForegroundColor blue "Loading: $scriptPath"
        $executionTime = Measure-Command {
			. $scriptPath
		}
		Write-Host -NoNewline " $($clockIcons[0])"
		Write-Host -ForegroundColor darkblue " $($executionTime.TotalMilliseconds) ms"
    }
}

# list user defined functions
function pfunc {
	Get-Command -CommandType Function | Where-Object { -not [string]::IsNullOrEmpty($_.Source) -eq $false } | Select-Object -Property Name | findstr /v "^[a-zA-Z0-9]:"
}

function p {
    powershell
	#& "C:\Program Files\WindowsApps\Microsoft.PowerShell_7.4.4.0_x64__8wekyb3d8bbwe\pwsh.exe"
}

function ep {
    np $PROFILE
}

function cdot {
    Set-Location $HOME\Code\dot-files
}

function cm {
    python $home\Code\dot-files\scripts\clipboard-manipulator.py $args
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

function stash {
    param (
        [string]$message
    )
	
	if (-not $message) {
        $message = Read-Host -Prompt "Message?"
    }
	
	$command = "git stash push --include-untracked --message ""$message"""
	Write-Host -ForegroundColor DarkCyan $command
	Invoke-Expression $command
}

function which {
	param (
		[string]$Command
	)
	
	echo (Get-Command $Command).Source
}

function Kill-Port {
    param (
        [string]$Port
    )

    $Processes = Get-NetTCPConnection | Where-Object { $_.LocalPort -eq $Port }

    if ($Processes) {
        foreach ($Process in $Processes ) {
            $command = "Stop-Process -Id $($Process.OwningProcess) -Force"
            Write-Host -ForegroundColor $commandColor $command
            Invoke-Expression $command
        }
    } else {
        Write-Host -ForegroundColor $warningColor "No process found for port $Port"
    }
}

function Restart-Visual-Studio{
	taskkill /F /IM devenv.exe
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

function copy-current-branch-name {
	git branch --show-current | Set-Clipboard
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
oh-my-posh init pwsh --config "$HOME\Code\dot-files\hotstick.ck.omp.json"| Invoke-Expression

$env:POSH_GIT_ENABLED = $true