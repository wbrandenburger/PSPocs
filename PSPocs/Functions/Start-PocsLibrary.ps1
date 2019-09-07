# ===========================================================================
#   Start-PocsLibrary.ps1 ---------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Start-PocsLibrary {

    <#
    .SYNOPSIS
        Starts a specific literature and document manager session.

    .DESCRIPTION
        Starts a specific literature and document manager session. All available libraries can be accessed by autocompletion.

    .PARAMETER Name

    .PARAMETER Silent

    .EXAMPLE
        PS C:\> Start-VirtualEnv -Name venv

        [PSVirtualEnv]::SUCCESS: Virtual enviroment 'venv' was started.

        [venv] PS C:\>
        
        -----------
        Description
        Starts the virtual environment 'venv', which must exist in the predefined directory. All available libraries can be accessed by autocompletion.

    .EXAMPLE
        PS C:\> start-venv venv

        [PSVirtualEnv]::SUCCESS: Virtual enviroment 'venv' was started.

        -----------
        Description
        Starts the virtual environment 'venv' with predefined alias of command.

    .INPUTS
        System.String. Name

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([Void])]

    Param(
        [ValidateSet([ValidatePocsLibStrict])]     
        [Parameter(Position=1, Mandatory=$True, ValueFromPipeline=$True, HelpMessage="Name of document and bibliography library, which should be started.")]
        [System.String] $Name,

        [Parameter(HelpMessage="If switch 'silent' is true no output will written to host.")]
        [Switch] $Silent
    )

    Process {

        # deactivation of a running virtual environment
        Restore-PocsLibrary

        # activate the virtual environment
        Set-PocsLibrary -Name $Name

        if (-not $Silent) {
            Write-FormattedSuccess -Message "Document and bibliography library '$Name' was started." -Module $PSPocsLib.Name -Space
        }
    }
}
