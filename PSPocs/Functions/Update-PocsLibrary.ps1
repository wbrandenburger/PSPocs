# ===========================================================================
#   Update-PocsLibrary.ps1 --------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Update-PocsLibrary {

    <#
    .DESCRIPTION
        Update content of literature and document file while reading from package's configuration file.
    
    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding)]
    
    [OutputType([Void])]

    Param()

    Process{

        if (-not $(Test-Path -Path $PSPocs.Config)){
            Write-FormattedError -Message "Configuration file for papis $($PSPocs.Config) cannot be found." -Module $PSPocs.Name
            return
        }
        
        # read general literature and document manager config file and add it to main module variable
        $PSPocs.ConfigContent = Get-IniContent -FilePath $PSPocs.Config -IgnoreComments
        
        # general keys of literature and document manager config file, which does not define a library
        $general_section = "settings tui"

        # generate general information
        $PSPocs.Library = @()
        $PSPocs.ConfigContent.Keys  | ForEach-Object {
            $section = $_
            $content = $PSPocs.ConfigContent[$section]

            # generate general information for each literature and document librar
            $virtual_env = $Null
            if ( $content.Keys -contains "virtual-env") {
                $virtual_env = $content["virtual-env"]
            }
            
            $PSPocs.Library += New-Object -TypeName PSCustomObject -Property @{
                Name = $section
                Content = $content
                Library = $(-not $($general_section -match $section))
                VirtualEnv = $virtual_env
            }
        }
    }
}