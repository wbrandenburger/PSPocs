# ===========================================================================
#   Get-PocsConfigContent.ps1 -----------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-PocsConfigContent {

    <#
    .DESCRIPTION
        Get content of literature and document file for preprocessing.

    .PARAMETER Name

    .INPUTS
        System.String. Name
    
    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param(
        [ValidateSet([ValidatePocsSection])]     
        [Parameter(Position=1, ValueFromPipeline=$True, HelpMessage="Name of document and bibliography library.")]
        [System.String] $Name,
   
        [Parameter(Position=2, HelpMessage="Content of literature and document manager config file.")]
        [System.Object] $Content
    )

    Process{

        # read general literature and document manager config file and add it to main module variable
        if (-not $Content) {
            $PSPocs.ConfigContent = Get-IniContent -FilePath $PSPocs.Config -IgnoreComments
        }
        else{
            $PSPocs.ConfigContent = $Content
        }
        
        # general keys of literature and document manager config file, which does not define a library
        $general_keys = "settings tui"

        # generate general information
        $PSPocs.Library = @()
        $PSPocs.ConfigContent.Keys  | ForEach-Object {
            $config_section = $_
            # generate general information for each literature and document librar
            $PSPocs.Library += New-Object -TypeName PSCustomObject -Property @{
                Name = $config_section
                Library = $(-not $($general_keys -match $config_section))
                Content = $PSPocs.ConfigContent[$config_section]
            }
        }
    }
}