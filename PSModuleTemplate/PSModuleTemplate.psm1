<#
	Load libray's used in module
#>
$x64Libs = Get-ChildItem -LiteralPath "$PSScriptRoot\Libs\x64" -Recurse -Include "*.dll" -File
$x86Libs = Get-ChildItem -LiteralPath "$PSScriptRoot\Libs\x64" -Recurse -Include "*.dll" -File
$universalLibs = Get-ChildItem -LiteralPath "$PSScriptRoot\Libs\Universal" -Recurse -Include "*.dll" -File

if([System.Environment]::Is64BitProcess -and $x64Libs) {
	# Load x64 library's only when powershell is running in x64 mode
	$x64Libs | ForEach-Object -Begin {
		Write-Verbose "Loading x64 library's..."
	} -Process {
		Add-Type $PSItem.FullName
	} -End {
		Write-Verbose "Finished Loading x64 library's."
	}
} elseif($x86Libs) {
	# Load x86 library's when powershell is not running in x64 mode
	$x86Libs | ForEach-Object -Begin {
		Write-Verbose "Loading x86 library's..."
	} -Process {
		Add-Type $PSItem.FullName
	} -End {
		Write-Verbose "Finished Loading x86 library's."
	}
}
Remove-Variable -Name x64Libs, x86Libs

if($universalLibs) {
	# Load library's that work in both x64 and x86. This could be x86 libray's that don't have a x64 version.
		$universalLibs | ForEach-Object -Begin {
		Write-Verbose "Loading universal library's..."
	} -Process {
		Add-Type $PSItem.FullName
	} -End {
		Write-Verbose "Finished Loading universal library's."
	}
}
Remove-Variable -Name universalLibs
