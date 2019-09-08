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
        System.Object. Library.

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param(

        [Parameter(Position=1, HelpMessage="Structure of library, containing details about the ocomposition of sections.")]
        [System.Object] $Structure,

        [Parameter(HelpMessage="Performed action for logging purposes.")]
        [System.String] $Action
    )

    Process{

        # backup for updating literature and document libraries
        New-ConfigBackup -Structure $Structure -Action $Action

        # backup for updating literature and document libraries

        $Structure | ForEach-Object{
            
            # write module config content to literature and document library file
      
            $_.Source | Out-IniFile -FilePath $_.Path -Force -Loose -Pretty

        }

        Write-FormattedSuccess -Message "Action $($Action) accomplished " -Module $PSPocs.Name

        # update module structures
        Get-PocsConfigContent
    } 
}