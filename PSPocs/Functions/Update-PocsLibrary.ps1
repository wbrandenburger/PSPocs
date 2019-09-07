# ===========================================================================
#   Update-PocsLibrary.ps1 --------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Update-PocsLibrary {

    <#
    .DESCRIPTION
        Update existing literature and document libraries   
    
    .PARAMETER Library

    .PARAMETER Action

    .INPUTS
        System.Object. Library

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param(

        [Parameter(Position=1, ValueFromPipeline=$True, HelpMessage="Literature and document libraries.")]
        [System.Object] $Library,

        [Parameter(HelpMessage="Performed action for logging purposes.")]
        [System.String] $Action
    )

    Process{
        
        # update module's config content
        if ($Library) {
            $Library.Keys | ForEach-Object {
                $PSPocs.ConfigContent[$_] = $Library[$_]
            }
        }

        # backup for updating literature and document libraries
        New-ConfigBackup -Source $PSPocs.Config -Action $Action

        # write module config content to literature and document library file
        $PSPocs.ConfigContent | Out-IniFile -FilePath $PSPocs.Config -Force -Loose -Pretty

        # update module structures
        Get-PocsConfigContent

        Write-FormattedSuccess -Message "Action $($Action) accomplished " -Module $PSPocs.Name
    } 
}