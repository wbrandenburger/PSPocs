# ===========================================================================
#   Get-Validation.ps1 ------------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-ValidatePocsLib {

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
function Get-ValidateSection {

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