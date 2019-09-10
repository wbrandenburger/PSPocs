# ===========================================================================
#   PSPocs_Config.ps1 -------------------------------------------------------
# ===========================================================================

#   configuration -----------------------------------------------------------
# ---------------------------------------------------------------------------
$PSPocs = New-Object -TypeName PSCustomObject -Property @{
    Name = $Module.Name

    Config = (Get-ConfigProjectFile -Name "Papis") -replace "\.ini", ""
    ConfigContent = $Null

    Library = @()
    LibraryDefault = $default_library

    Logger = @()
}
