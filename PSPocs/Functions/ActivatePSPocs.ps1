# ===========================================================================
#   ActivatePocsAutocompletion.ps1 ------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function ActivatePocsAutocompletion {

    <#
    .DESCRIPTION
        Import PSPocs activating autocompletion for validating input of module functions.

    .OUTPUTS
        ScriptBlock. Scriptblock with using command.
    #>

    [CmdletBinding(PositionalBinding)]

    [OutputType([ScriptBlock])]

    Param()

    Process {

        return $(Get-Command $(Join-Path -Path $Module.ClassDir -ChildPath "ModuleValidation.ps1") | Select-Object -ExpandProperty ScriptBlock)

    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function ValidatePocsLibrary {

    <#
    .DESCRIPTION
        Return values of literature and document libraries for the use of validating existing libraries
    
    .OUTPUTS
        System.String[]. Virtual environments
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([System.String[]])]

    Param()

    Process{

       return $PSPocs.Library | Where-Object {$_.Library -eq "True"} |Select-Object -ExpandProperty Name
    
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function ValidatePocsConfigSection {

    <#
    .DESCRIPTION
        Return values of literature and document libraries for the use of validating existing libraries
    
    .OUTPUTS
        System.String[]. Virtual environments
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([System.String[]])]

    Param()

    Process{

       return $PSPocs.Library | Select-Object -ExpandProperty Name
    
    }
}
