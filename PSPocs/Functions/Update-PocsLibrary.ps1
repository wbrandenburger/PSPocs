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
        
        if (-not $(Get-VirtualEnv -Unformatted | Where-Object { $_.Name -eq $PSPocs.VirtualEnv})){
            Write-FormattedWarning -Message "Virtual environment '$($PSPocs.VirtualEnv)' cannot be found. Installation of new virtual environment." -Module $PSPocs.Name

            New-VirtualEnv -Name $PSPocs.VirtualEnv
        } 

        if (-not $((Get-VirtualEnv -Name $PSPocs.VirtualEnv -Unformatted) | Where-Object { $_.Name -eq "papis"})){
            Write-FormattedWarning -Message "Package 'papis' can not be found in virtual environment '$($PSPocs.VirtualEnv)' can not be found. Installation of 'papis'." -Module $PSPocs.Name

            Install-VirtualEnv -Name $PSPocs.VirtualEnv -Package "$($PSPocs.PapisPckg)" 2>&1> $Null
        } 

        if (-not $(Test-Path -Path $PSPocs.PapisConfig)){
            Write-FormattedError -Message "Papis configuration file '$($PSPocs.PapisConfig)' cannot be found." -Module $PSPocs.Name
            return
        }
        
        # read general literature and document manager config file and add it to main module variable
        $PSPocs.PapisConfigContent = Get-IniContent -FilePath $PSPocs.PapisConfig -IgnoreComments
        
        # general keys of literature and document manager config file, which does not define a library
        $general_section = "settings tui"

        # generate general information
        $PSPocs.Library = @()
        $PSPocs.PapisConfigContent.Keys  | ForEach-Object {
            $section = $_
            $content = $PSPocs.PapisConfigContent[$section]

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