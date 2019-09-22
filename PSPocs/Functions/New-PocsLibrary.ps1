# ===========================================================================
#   New-PocsLibrary.ps1 -----------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function  New-PocsLibrary {

    <#
    .DESCRIPTION
        Add a literature and document library and store it in package's configuration file.

    .PARAMETER Name

    .PARAMETER VirtualEnv

    .PARAMETER Identifier

    .INPUTS
        Name.

    .OUTPUTS
        None.
    #>

    [CmdletBinding(PositionalBinding)]

    [OutputType([Void])]

    Param(

        [Parameter(Position=1, Mandatory, ValueFromPipeline, HelpMessage="Name of document and bibliography library.")]
        [System.String] $Name,

        [ValidateSet([ValidateVirtualEnv])]
        [Parameter(Position=2, HelpMessage="Name of virtual environment.")]
        [System.String] $VirtualEnv = $PSPocs.VirtualEnv,

        [Parameter(HelpMessage="Extension identifier of document and bibliography library.")]
        [System.String] $Identifier = ""
    )
    
    Process {

        # update existing literature and document libraries
        Update-PocsLibrary

        # create structure for subsitution of placeholders in default library
        $object = @{
            NAME = $Name
            VIRTUALENV = $VirtualEnv
            ID = $Identifier
            IDBOOL = if ($Identifier) {"true"} else {"false"}
        }

        # replace placeholders in default library with spcified parameters
        $library = @{$Name = [Ordered] @{}}
        $PSPocs.LibraryDefault | ForEach-Object {
            $key = Get-FormattedString -String $_["key"] -Object $object
            $value = Get-FormattedString -String $_["value"] -Object $object
            $condition = Get-FormattedString -String $_["condition"] -Object $object

            if ($condition) {
                $library[$Name] += @{ $key = $value }
            }
        }
 

        # # get specified library and create structure fur further processing
        $temp_file = New-TemporaryConfig -Library $library -Open
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

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-FormattedString {

    Param(
        [Parameter(HelpMessage="Search string.")]
        [System.String] $String,

        [Parameter(HelpMessage="Object with elements for substitution.")]
        [System.Object] $Object
    )

    # settings
    $pattern = "\%\(([a-z-_]+)\)s"
    $result = $String
    $keys = $Object.Keys

    # if there are matches each result will be further evaluated
    [Regex]::Matches($String, $Pattern, "IgnoreCase").Groups | Where-Object { $_.Name -eq 1} | Select-Object -ExpandProperty Value | ForEach-Object {
        # replace the pattern in given field as well as return formatted string
        if ($Keys -contains $_){
            $result = [Regex]::Replace($result, "\%\(($_)\)s", $Object[$_], "IgnoreCase")
        }
    }

    return $result
}
