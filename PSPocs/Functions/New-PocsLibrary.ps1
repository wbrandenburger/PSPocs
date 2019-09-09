# ===========================================================================
#   New-PocsLibrary.ps1 -----------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function  New-PocsLibrary {

    <#
    .DESCRIPTION
        Add a literature and document library and write it to config file.

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([Void])]

    Param()
    
    Process {

        $temp_file = New-TemporaryConfig -Library $PSPocs.LibraryDefault -Open
        $library_structure = Get-LibraryStructure

        # user input for updating or cancelling editing document and bibliography libraries
        $message  = "Add file to document and bibliography database"
        $question = "Do you want to add the library to document and bibliography database?"
        $choices = "&Add", "&Quit"
        $decision = $Host.UI.PromptForChoice($message, $question, $choices, 1)

        # quit if chosen
        if ($decision -eq 1) {
            return
        }

        # get modified document and bibliography libraries
        $library_structure = Add-LibraryStructure -Library $( Get-IniContent -FilePath $temp_file -IgnoreComments) -Structure $library_structure

        # add key to literature and document configuration settings and update module structures
        Update-PocsLibraryFromInput -Structure $library_structure -Action "add"
    }
}