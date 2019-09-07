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

    .PARAMETER Full

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
        [System.String] $Name,

        [Parameter(HelpMessage="Return information specific document and bibliography library settings.")]
        [Switch] $Full
    )

    Process{

        if ($Name){
            # get specific document and bibliography library
            $library =  $PSPocs.Library | Where-Object {$_.Name -eq $Name} | Select-Object -ExpandProperty "Content"
            if ($library.Keys -contains "local-config-file"){
                if (Test-Path -Path $library["local-config-file"]){
                    $settings = Get-IniContent -FilePath $library["local-config-file"] -IgnoreComments
                }
            }
            if (-not $Full) {
                return $library | Format-Table
            }
            else {
                return $library + $settings | Format-Table
            }
        }
        else {
            # get all existing document and bibliography libraries
             $PSPocs.Library | Select-Object -Property Name, Library | Format-Table
        }
    }
}