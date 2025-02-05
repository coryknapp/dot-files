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

function Monitor-DirectoryForXML {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    # Ensure the provided path exists
    if (-not (Test-Path -Path $Path)) {
        Write-Error "The specified path does not exist: $Path"
        return
    }

    # Create a FileSystemWatcher to monitor the directory
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $Path
    $watcher.Filter = "*.xml"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true

    # Define an event action
    $action = {
        $fullPath = $Event.SourceEventArgs.FullPath
        $changeType = $Event.SourceEventArgs.ChangeType
        if ($changeType -eq "Created") {
            Write-Host "New XML file detected: $fullPath" -ForegroundColor Green
            Start-Process -FilePath $fullPath
        }
    }

    # Register the event
    $registeredEvent = Register-ObjectEvent -InputObject $watcher -EventName Created -Action $action

    Write-Host "Monitoring $Path for new XML files. Press Ctrl+C to stop."

    # Keep the function running
    try {
        while ($true) {
            Start-Sleep -Seconds 1
        }
    } finally {
        # Cleanup
        Unregister-Event -SourceIdentifier $registeredEvent.Name
        $watcher.Dispose()
        Write-Host "Stopped monitoring."
    }
}

function Process-Status {
    param (
        $processList
    )
	$checkmark = [char]0x2713
	$noX = [char]0x2718
	
    foreach ($processName in $processList) {
        # Check if the process is running
        $process = Get-Process -Name $processName -ErrorAction SilentlyContinue

        if ($process) {
			Write-Host -NoNewline -ForegroundColor green "$checkmark $processName"
			$processTimeText = Process-Status-Last-Built-Text $process
			Write-Host -ForegroundColor white " $processTimeText"
        } else {
            Write-Host -ForegroundColor red "$noX $processName"
        }
    }
}

function Process-Status-Last-Built-Text {
    param (
        [Parameter(Mandatory = $true)]
        $process
    )

	$uptime = (Get-Date) - $process.StartTime

    $components = @()
    
	if ($uptime.Days -gt 0) {
        $components += "$($uptime.Days) $(Pluralize 'day')"
    }
    if ($uptime.Hours -gt 0) {
        $components += "$($uptime.Hours) $(Pluralize 'hour')"
    }
    if ($uptime.Minutes -gt 0) {
        $components += "$($uptime.Minutes) $(Pluralize 'minutes')"
    }
	
    $components += "$($uptime.Seconds) $(Pluralize 'seconds')"

	return $components -join ", "
}

function Pluralize {
	param (
		[string]$word,
		[int]$count
	)
	
	if( $count -eq 1 ) {
		return $word + "s"
	}
	
	return $word
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

function commit {
	git commit -m $(git rev-parse --abbrev-ref HEAD)
}

function which {
	param (
		[string]$Command
	)
	
	echo (Get-Command $Command).Source
}

function ag-gi {
	ag --path-to-ignore .gitignore $($args[0])
}

function c {
    param (
        [Parameter(Mandatory = $true)]
        [string]$InputPath
    )

    if (Test-Path -Path $InputPath -PathType Container) {
        # Input is a directory
        $ResolvedPath = Resolve-Path -Path $InputPath
    } elseif (Test-Path -Path $InputPath -PathType Leaf) {
        # Input is a file
        $ResolvedPath = Split-Path -Path $InputPath -Parent
    } else {
        throw "The provided path does not exist: $InputPath"
    }
	
    Set-Location -Path $ResolvedPath
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


Function ztime {
	(Get-Date).ToUniversalTime()
}

Function Delete-Suo-file {
	$solutionPath = Get-Location

	# Find the .suo file in the .vs directory
	$suoFilePath = Get-ChildItem -Path $solutionPath -Recurse -Filter "*.suo" -ErrorAction SilentlyContinue | Select-Object -First 1

	if ($suoFilePath) {
		Write-Host "Deleting .suo file: $($suoFilePath.FullName)"
		Remove-Item -Path $suoFilePath.FullName -Force
		Write-Host "The .suo file has been deleted."
	} else {
		Write-Host "No .suo file found in the specified solution path."
	}
}

# # fancy prompt
Import-Module -Name posh-git
oh-my-posh init pwsh --config "$HOME\Code\dot-files\hotstick.ck.omp.json"| Invoke-Expression

$env:POSH_GIT_ENABLED = $true