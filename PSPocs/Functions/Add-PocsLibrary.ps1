# ===========================================================================
#   Add-PocsLibrary.ps1 -----------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function  Add-PocsLibrary {

    <#
    .DESCRIPTION
        Add a literature and document library and write it to config file.
    
    .PARAMETER Content

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([Void])]

    Param(
        [Parameter(HelpMessage="Content which has to be added depending on specified document and bibliography library.")]
        [System.Object] $Content
    )
    
    Process {

        $library_new = $Content
        if (-not $library_new) {

            $temp_file = New-TempPocsConfig -Library $PSPocs.LibraryDefault -Open

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
            $library_new  = Get-IniContent -FilePath $temp_file -IgnoreComments
        }

        # add key to literature and document configuration settings and update module structures
        Update-PocsLibrary -Library $library_new -Action "add:$($library_new.Keys)"
    }
}