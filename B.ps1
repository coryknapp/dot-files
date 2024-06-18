function Go-BackDirectories {
    param (
        [int]$n
    )

    for ($i = 1; $i -le $n; $i++) {
        Set-Location ..
    }
}

# Some scoping issue prevents the Invoke-Expression from defining the function
# do I have to do this manually below
#function define-back-function {
    #param (
        #[int]$n
    #)
		
	#$functionName = -join ("b" * $n)
	#$functionBody = "Go-BackDirectories $n"
	#$functionDefinition = "function $functionName { $functionBody }"

	#Write-Host $functionDefinition
	#Invoke-Expression $functionDefinition
#}

#for ($i = 1; $i -le 10; $i++) {
    #define-back-function $i
#}

function b { Go-BackDirectories 1 }
function bb { Go-BackDirectories 2 }
function bbb { Go-BackDirectories 3 }
function bbbb { Go-BackDirectories 4 }
function bbbbb { Go-BackDirectories 5 }
function bbbbbb { Go-BackDirectories 6 }
function bbbbbbb { Go-BackDirectories 7 }
function bbbbbbbb { Go-BackDirectories 8 }
function bbbbbbbbb { Go-BackDirectories 9 }
function bbbbbbbbbb { Go-BackDirectories 10 }

function bl {
	$currentDirectory = Get-Location
	$directoryElements = $currentDirectory.Path -split '\\'
	
	[array]::Reverse($directoryElements)
	
	Write-Host "`t$($directoryElements[0])"
	for ($i = 1; $i -lt $directoryElements.Length; $i++) {
		Write-Host "${i}:`t$($directoryElements[$i])"
	}
	
	$userInput = Read-Host "Where to? "	
	Go-BackDirectories $userInput
}