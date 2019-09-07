# ===========================================================================
#   Restore-PocsConfig.ps1 -------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function  Restore-PocsConfig {

    <#
    .DESCRIPTION
        Restore literature and document config files with specified index.

    .PARAMETER Index
    
    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param(
        [Parameter(HelpMessage="Restore generated document and bibliography library with specified index.")]
        [Int] $Index = $PSPocs.Logger.Length - 1
    )

    Process{
        $history_length = $PSPocs.Logger.Length
        # if index is greater than the history array break
        if ($Index -gt  $history_length - 1) {
            return
        }
        
        # backup for restoring literature and document libraries
        $source = $PSPocs.Logger[$Index].Backup
        $backup = $PSPocs.Logger[$Index].Source
        Copy-Item -Path $source -Destination $backup -Force
        New-ConfigBackup -Source $source -Action "restore"
        
        # restore specified file
        Copy-Item -Path $backup -Destination $destination -Force
        
        Write-FormattedSuccess -Message "[CP] $($backup) to $($destination)" -Module $PSPocs.Name
    }
}