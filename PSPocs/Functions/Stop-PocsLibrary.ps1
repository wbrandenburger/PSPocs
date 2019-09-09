# ===========================================================================
#   Stop-PocsLibrary.ps1 ----------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Stop-PocsLibrary {

    <#
    .SYNOPSIS
        Stops current running literature and document manager session.

    .DESCRIPTION
        Stops current running literature and document manager session.

    .PARAMETER VirtualEnv

    .PARAMETER Silent
    
    .EXAMPLE
        [venv] PS C:\> Stop-VirtualEnv

        [PSVirtualEnv]::SUCCESS: Virtual enviroment 'venv' was stopped.

        PS C:\>

        -----------
        Description
        Stops current virtual environment. 

    .EXAMPLE
        [venv] PS C:\> Stop-venv

        SUCCESS: Virtual enviroment 'venv' was stopped.

        PS C:\>
        
        -----------
        Description
        Stops current virtual environment with predefined alias of command.

    .INPUTS
        None.

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([Void])]

    Param(
        [Parameter(HelpMessage="Currently running virtual environment will also be stopped.")]
        [Switch] $VirtualEnv,

        [Parameter(HelpMessage="If switch 'silent' is true no output will written to host.")]
        [Switch] $Silent
    )

    Process { 

        # get a running document and bibliography session
        $pocs_lib_old = Get-ActivePocsLib
        if (-not $pocs_lib_old){
            if (-not $Silent) {
                Write-FormattedWarning -Message "There was no document and bibiography session found." -Module $PSPocsLib.Name -Space
            }
            return
        }

        # deactivation of a running document and bibliography session
        Restore-PocsLibrary
        if ($VirtualEnv -and $(Get-ActiveVirtualEnv)) {
            Restore-VirtualEnv
        }

        # if the environment variable is not empty, deactivation failed
        if (-not $Silent) {
            if ($pocs_lib_old -and $pocs_lib_old -eq $(Get-ActivePocsLib)) {
                Write-FormattedError -Message "Document and bibliography session with library '$pocs_lib_old' could not be stopped." -Module $PSPocsLib.Name -Space
            }         
            else{
                Write-FormattedSuccess -Message "Document and bibliography session with library '$pocs_lib_old' was stopped." -Module $PSPocsLib.Name -Space
            }
        }
    }
}
