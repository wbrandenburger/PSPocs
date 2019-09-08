# ===========================================================================
#   Get-PocsLibrary.ps1 -----------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-PocsLibrary {

    <#
    .DESCRIPTION
        Get existing literature and document libraries

    .PARAMETER Name

    .INPUTS
        System.String. Name
    
    .OUTPUTS
        System.object[]. literature and document libraries
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([System.Object])]

    Param(
        [ValidateSet([ValidatePocsSection])]     
        [Parameter(Position=1, ValueFromPipeline=$True, HelpMessage="Name of document and bibliography library.")]
        [System.String] $Name
    )

    Process{

        if ($Name){
            # get specific document and bibliography library
            return $PSPocs.Library | Where-Object {$_.Name -eq $Name} | Select-Object -ExpandProperty "Content" | Format-Table
        }
        else {
            # get all existing document and bibliography libraries
            return $PSPocs.Library | Format-Table -Property Name, Library, @{
                Label = "Path"
                Expression = {if ($_.Library){$_.Content["dir"]} else {$Null}}
            }, @{
                Label = "Content"
                Expression = {$_.Content}
            }
        }
    }
}