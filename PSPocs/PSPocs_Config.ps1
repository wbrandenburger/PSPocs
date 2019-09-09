# ===========================================================================
#   PSPocs_Config.ps1 -------------------------------------------------------
# ===========================================================================

#   configuration -----------------------------------------------------------
# ---------------------------------------------------------------------------
@(
    @{  # manifest 
        Name="Manifest"
        Value=Join-Path -Path $Module.Dir -ChildPath "$($Module.Name).psd1"
    }
    @{  # directory of functions
        Name="ClassDir"
        Value=Join-Path -Path $Module.Dir -ChildPath "Classes"
    } 
    @{  # directory of functions
        Name="FunctionsDir"
        Value=Join-Path -Path $Module.Dir -ChildPath "Functions"
    }
    @{  # directory of functions
        Name="TestsDir"
        Value=Join-Path -Path $Module.Dir -ChildPath "Tests"
    }
) | ForEach-Object {
    $Module | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value
}

#   settings ----------------------------------------------------------------
# ---------------------------------------------------------------------------
$PSPocs = New-Object -TypeName PSCustomObject -Property @{
    Name = $Module.Name
    Config = (Get-ConfigProjectFile -Name "Papis") -replace "\.ini", ""
    ConfigContent = $Null
    Library = @()
    Logger = @()
    LibraryDefault = $default_library
}


