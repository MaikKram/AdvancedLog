@{
	# Script module or binary module file associated with this manifest
	ModuleToProcess = 'AdvancedLog.psm1'
	
	# Version number of this module.
	ModuleVersion = '1.4.1'
	
	# ID used to uniquely identify this module
	GUID = '04e4e1cf-1edd-4d8d-9ef1-8bd3bc7c210d'
	
	# Author of this module
	Author = 'Maik Krammer'
	
	# Company or vendor of this module
	CompanyName = 'CANACOM'
	
	# Copyright statement for this module
	Copyright = '2016'
	
	# Description of the functionality provided by this module
	Description = 'This module provides advanced logging functions'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '4.0'
	
	# Minimum version of the .NET Framework required by this module
	DotNetFrameworkVersion = '4.0'

	# Script files (.ps1) that are run in the caller's environment prior to importing this module
	ScriptsToProcess = @('AdvancedLog.init.ps1')

	# Functions to export from this module
	FunctionsToExport = 'Write-Log', 'Fill-Line'
	
	# List of all modules packaged with this module
	ModuleList = @('AdvancedLog.psm1')
	
	# List of all files packaged with this module
	FileList = @('AdvancedLog.psm1', 'AdvancedLog.psd1')
}