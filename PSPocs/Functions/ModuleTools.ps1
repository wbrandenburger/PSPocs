# ===========================================================================
#   Module-Tools.ps1 --------------------------------------------------------
# ===========================================================================

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Set-PocsLibrary {

    <#
    .DESCRIPTION
        Set environment variable for using literature and document manager in current session.
    
    .PARAMETER Name

    .OUTPUTS 
        None.
    #>

    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([Void])]

    Param(
        [Parameter(Position=1, HelpMessage="Name of literature and document library.")]
        [System.String] $Name
    )

    Process {
        # checks whether a literature and document manager session has been already running
        $pocs_lib_old = Get-ActivePocsLib
        if($pocs_lib_old) {
            [System.Environment]::SetEnvironmentVariable($PSPocs.ProjectEnvOld, $pocs_lib_old, "process")
        }

        # start literature and document manager session
        if ($Name) {

            #set literature and document manager environment variable
            [System.Environment]::SetEnvironmentVariable($PSPocs.ProjectEnv, $Name,"process")
        }
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Restore-PocsLibrary{
    <#
    .DESCRIPTION
        Restore environment variable, which are set by Set-PocsLibrary.

    .OUTPUTS 
        None.
    #>

    [OutputType([Void])]

    Param ()

    Process {
        # stop literature and document manager session
        [System.Environment]::SetEnvironmentVariable($PSPocs.ProjectEnv, $Null,"process")

        # restart previously running literature and document manager session 
        $pocs_lib_old = [System.Environment]::GetEnvironmentVariable($PSPocs.ProjectEnvOld, "process")
        if($pocs_lib_old) {
            [System.Environment]::SetEnvironmentVariable($PSPocs.ProjectEnvOld, $Null, "process")
            Set-PocsLibrary -Name $pocs_lib_old
        }
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function Get-ActivePocsLib {

    <#
    .DESCRIPTION
        Detects activated literature and document manager session.

    .OUTPUTS 
        System.String. Activated literature and document manager session.
    #>
    
    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([System.String])]

    Param()
        
    Process {
        $pocs_lib = [System.Environment]::GetEnvironmentVariable($PSPocs.ProjectEnv, "process")

        if ($pocs_lib) {
            return $pocs_lib
        }
    }
}


#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function New-TempPocsConfig {

    <#
    .DESCRIPTION
        Creates a temporary file and writes libraries to this.

    .PARAMETER Library

    .PARAMETER Open

    .INPUTS
        System.Object. Library

    .OUTPUTS 
        System.String. Activated literature and document manager session.
    #>
    
    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([System.String])]

    Param(

        [Parameter(Position=1, ValueFromPipeline=$True, HelpMessage="Literature and document libraries.")]
        [System.Object] $Library,

        [Parameter(Position=1, ValueFromPipeline=$True, HelpMessage="If switch is true, the created file will be opened in system's editor.")]
        [Switch] $Open
    )
    
    Process {

        # create a config file and write specified libraries to file
        $temp_file = New-TemporaryFile -Extension ".ini"
        $Library | Out-IniFile -FilePath $temp_file -Force -Loose -Pretty
        
        # open if corresponding switch is true
        if ($Open) {
            Start-Process -FilePath "code" -NoNewWindow -ArgumentList "--new-window",  "--disable-gpu", $temp_file
        }

        return $temp_file
    }
}

#   function ----------------------------------------------------------------
# ---------------------------------------------------------------------------
function New-ConfigBackup {

    <#
    .DESCRIPTION
        Creates a backup file for configuration file.

    .PARAMETER Library

    .OUTPUTS 
        None. 
    #>
    
    [CmdletBinding(PositionalBinding=$True)]

    [OutputType([System.String])]

    Param(

        [Parameter(HelpMessage="Source.")]
        [System.String] $Source,

        [Parameter(HelpMessage="Performed action for logging purposes.")]
        [System.String] $Action
    )
    
    Process {
        
        # create temporary file with content of source
        $logger_length = $PSPocs.Logger.Length
        $temp_file = New-TemporaryFile -Extension ".ini"

        # copy source to backup location
        Copy-Item -Path $Source -Destination $temp_file -Force

        # store information about backup in module logger
        $PSPocs.Logger += [PSCustomObject] @{
            "Id" =  $logger_length
            "Date" = Get-Date -Format "HH:mm:ss MM/dd/yyyy"
            "Action" = $Action
            "Source" = $Source
            "Backup" = $temp_file
        }
    }
}

