# ===========================================================================
#   Remove-PocsLibrary.ps1 --------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Remove-PocsLibrary {

    <#
    .DESCRIPTION
        Remove existing literature and document libraries

    .PARAMETER Name

    .INPUTS
        System.String. Name        

    .OUTPUTS
       None.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param(
        [ValidateSet([ValidatePocsLibStrict])]     
        [Parameter(Position=1, ValueFromPipeline=$True, Mandatory=$True, HelpMessage="Name of document and bibliography library.")]
        [System.String] $Name
    )

    Process{

        # remove key from literature and document configuration settings and update module structures
        $PSPocs.ConfigContent.Remove($Name)
        Update-PocsLibrary -Action "remove"
    }
}