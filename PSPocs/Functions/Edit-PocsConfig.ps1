# ===========================================================================
#   Edit-PocsConfig.ps1 -----------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Edit-PocsConfig {

   <#
    .SYNOPSIS
        Edit the content of module's configuration file.

    .DESCRIPTION
        Edit the content of module's configuration file in defined editor.

    .EXAMPLE
        PS C:\> Edit-PocsConfig 

        -----------
        Description
        Open the content of module's configuration file in defined editor. for editing.

    .INPUTS
        None.

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding)]

    [OutputType([Void])]

    Param()

    Process {

        $editor_args = $($PSPocs.EditorArgs + " " + $Module.Config)
        
        # open existing requirement file
        if (Test-Path -Path $Module.Config){
            Start-Process -Path $PSPocs.Editor -NoNewWindow -Args $editor_args
        }
    }
}
