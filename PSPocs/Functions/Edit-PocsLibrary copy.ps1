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

    .PARAMETER Content

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
        [System.String] $Name,
  
        [Parameter(HelpMessage="Content which has to be modified depending on specified document and bibliography library.")]
        [System.Object] $Content
    )

    Process{

        $library_new = $Content
        if (-not $library_new) {

            if ($Name) {
                # get specific document and bibliography library
                $library = @{ 
                    $Name = $PSPocs.Library | Where-Object {$_.Name -eq $Name} | Select-Object -ExpandProperty "Content"
                }
            }
            else {
                # get all existing document and bibliography libraries
                $library = $PSPocs.ConfigContent
            }

            # create temporary config file, write specified information to this file, and open it for editing
            $temp_file = New-TempPocsConfig -Library $library -Open
  
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
            $library_new = Get-IniContent -FilePath $temp_file -IgnoreComments
        }

        # update keys in literature and document configuration settings and update module structures
        $action = $Name
        if (-not $Name){
            $action = "All"
        }
        Update-PocsLibrary -Library $library_new -Action "update:$($action)"
    }
}