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

        # if index is greater than the history array break
        if ($Index -gt $PSPocs.Logger.Length - 1) {
            return
        }
        
        # backup for restoring literature and document libraries
        $structure = @()
        $PSPocs.Logger[$Index].Files | ForEach-Object {
            $structure += @{"Path" = $_["Source"]}
        }
        New-ConfigBackup -Structure $structure -Action "restore"

        # restore literature and document config files with specified index
        $PSPocs.Logger[$Index].Files | ForEach-Object {
            $source = $_["Backup"]
            $destination = $_["Source"]
            Copy-Item -Path $source -Destination $destination -Force
            Write-FormattedSuccess -Message "[CP] $($source) to $($destination)" -Module $PSPocs.Name
        }

        # update module structures
        Get-PocsConfigContent
    }
}