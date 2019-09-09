# ===========================================================================
#   Remove-PocsLibrary.ps1 --------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Remove-PocsLibrary {

    <#
    .DESCRIPTION
        Remove existing literature and document libraries

    .PARAMETER Name

    .INPUTS
        System.String. Name        

    .OUTPUTS
        System.Object.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([System.Object])]

    Param(
        [ValidateSet([ValidatePocsLibStrict])]     
        [Parameter(Position=1, ValueFromPipeline=$True, HelpMessage="Name of document and bibliography library.")]
        [System.String] $Name
    )

    Process{

        # update existing literature and document libraries
        Update-PocsLibrary

        # get specified library and create structure fur further processing
        $library_structure = Get-LibraryStructure

        # get modified document and bibliography libraries
        $library_structure.Library.Remove($Name)
        $library_structure.Source = $library_structure.Library

        # remove key from literature and document configuration settings and update module structures
        Update-PocsLibraryFromInput -Structure $library_structure -Action "remove"
    }
}