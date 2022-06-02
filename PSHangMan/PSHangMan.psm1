# Universal psm file

# Get functions
$Functions = @( Get-ChildItem -Path $PSScriptRoot\scripts\*.ps1 -ErrorAction SilentlyContinue )

foreach($import in @($Functions )){
    try {
        . $import.FullName
        $import
    }
    catch {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}

# Aliases
# New-Alias -Name 'HangMan' -Value "Invoke-HangMan"

# Export everything in the folder
Export-ModuleMember -Function * -Cmdlet * -Alias *
