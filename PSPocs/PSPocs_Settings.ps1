# ===========================================================================
#   PSPocs_Settings.ps1 -----------------------------------------------------
# ===========================================================================

#   settings ----------------------------------------------------------------
# ---------------------------------------------------------------------------

# get existing literature and document libraries from general config file
if (Test-Path -Path $PSPocs.Config){
    Update-PocsLibrary
} else {
    Write-FormattedWarning -Message "Package papis may be not installed. Initialization of module is aborted." -Module $PSPocs.Name
}
