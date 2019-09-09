# ===========================================================================
#   Edit-PocsLibrary.ps1 ----------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Edit-PocsLibrary {

    <#
    .DESCRIPTION
        Get existing literature and document libraries

    .PARAMETER Name

    .INPUTS
        System.String. Name        

    .OUTPUTS
       None.
    #>

    [CmdletBinding(PositionalBinding=$True)]
    
    [OutputType([Void])]

    Param(
        [ValidateSet([ValidatePocsSection])]     
        [Parameter(Position=1, ValueFromPipeline=$True, HelpMessage="Name of document and bibliography library.")]
        [System.String] $Name
    )

    Process{

        $library_structure = Get-LibraryStructure -Name $Name
        $library = @{}
        $library_structure  | ForEach-Object {
            $library += $_.Library
        }

        # create temporary config file, write specified information to this file, and open it for editing
        $temp_file = New-TemporaryConfig -Library $library -Open

        # user input for updating or cancelling editing document and bibliography libraries
        $message  = "Edit document and bibliography libraries"
        $question = "Do you want to update your changes, or create a new object from library?"
        $choices = "&Update", "&Quit"
        $decision = $Host.UI.PromptForChoice($message, $question, $choices, 1)

        # quit if chosen
        if ($decision -eq 1) {
            return
        }

        # get modified document and bibliography libraries
        $library_structure = Update-LibraryStructure -Library $(Get-IniContent -FilePath $temp_file -IgnoreComments) -Structure $library_structure

        # update keys in literature and document configuration settings and update module structures
        $action = $Name
        if (-not $Name){
            $action = "All"
        }
        Update-PocsLibraryFromInput -Structure $library_structure -Action "update:$($action)"
    }
}