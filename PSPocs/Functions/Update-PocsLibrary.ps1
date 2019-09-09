# ===========================================================================
#   Update-PocsLibrary.ps1 --------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Update-PocsLibrary {

    <#
    .DESCRIPTION
        Update content of literature and document file for preprocessing.
    
    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param()

    Process{

        # read general literature and document manager config file and add it to main module variable
        $PSPocs.ConfigContent = Get-IniContent -FilePath $PSPocs.Config -IgnoreComments
        
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