function Windows-Line-Endings{
    param (
        [string]$inputFilePath
    )

	$content = Get-Content -Raw -Path $inputFilePath

	# Replace LF with CRLF
	$content = $content -replace "`n", "`r`n"

	# Write the modified content back to the file
	Set-Content -Path $inputFilePath -Value $content
}

function Unix-Line-Endings{
    param (
        [string]$inputFilePath
    )

	$content = Get-Content -Raw -Path $inputFilePath

	# Replace CRLF with LF
	$content = $content -replace "`r`n", "`n"

	# Write the modified content back to the file
	Set-Content -Path $inputFilePath -Value $content
}

function Revert-Line-Ending-Only-Changes-In-Repo{
	param (
        [switch]$NoConfirm,
		[switch]$Dry
    )
	
	Push-Location
	
	#Go to repo root
	Set-Location -Path (git rev-parse --show-toplevel)


	$changedFiles = git diff --name-only	
	$cases = Find-Only-Changed-Line-Endings $changedFiles
	

	foreach ($filePath in $cases) {
		Git-Revert-File -filePath:$filePath -NoConfirm:$NoConfirm -Dry:$Dry
	}
	
	Pop-Location
}

function Find-Only-Changed-Line-Endings{
    param (
        [string[]]$filePaths
    )
	
	$cases = @()
	
	foreach ($file in $filePaths) {
		if (Is-Git-Change-Only-Whitespace $file) {
			$cases += $file
		}
	}
	
	return $cases
}

function Is-Git-Change-Only-Whitespace{
	param (
        [string]$file
    )
	
    $diff = git diff --ignore-space-change -- $file

    return ($diff.Length -eq 0)
}

function Git-Revert-File{
	param (
		[string]$filePath,
        [switch]$NoConfirm,
		[switch]$Dry
    )
	
    if (-not $NoConfirm ) {
		Write-Host "Revert $filePath`?"
		$i = 'x'
		while ($i.ToUpper() -ne "Y") {
			$i = Read-Host "[Y]/[N]/[D]iff"
			if($i.ToUpper() -eq "N") {
				return
			}
			if($i.ToUpper() -eq "D") {
				git diff -- $filePath
			}
		}
    }
	
	Write-Host "Reverting $filePath"
	
    if (-not $Dry ) {
		git reset HEAD $filePath
		git checkout -- $filePath
	}
}