# ===========================================================================
#   Get-PocsConfigLogger.ps1 ------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function  Get-PocsConfigLogger {

    <#
    .DESCRIPTION
        Get literature and document config logger.
    
    .OUTPUTS
        System.Object. Literature and document config logger.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([System.Object])]

    Param()

    Process{

        return $PSPocs.Logger | Format-Table
    }
}