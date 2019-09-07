# ===========================================================================
#   PSPocs_Alias.ps1 --------------------------------------------------------
# ===========================================================================

#   aliases -----------------------------------------------------------------
# ---------------------------------------------------------------------------

@(
    @{ Name = "ls-pocs";     Value = "Get-PocsLibrary"}
    @{ Name = "new-pocs";     Value = "Add-PocsLibrary"}
    @{ Name = "rm-pocs";     Value = "Remove-PocsLibrary"}
    @{ Name = "start-pocs";     Value = "Start-PocsLibrary"}
    @{ Name = "stop-pocs";     Value = "Stop-PocsLibrary"}
    @{ Name = "vsx-pocs";     Value = "Edit-PocsLibrary"}

) | ForEach-Object {
    Set-Alias -Name $_.Name -Value $_.Value
}
