# ===========================================================================
#   PSPocs_Scripts.psm1 -----------------------------------------------------
# ===========================================================================

#   import ------------------------------------------------------------------
# ---------------------------------------------------------------------------
using namespace System.Management.Automation

$path = Join-Path -Path $(Split-Path -Path $MyInvocation.MyCommand.Path -Parent)  -ChildPath "Modules"
Get-Childitem -Path $path -Directory | Select-Object -ExpandProperty FullName | ForEach-Object {
    Import-Module -Name $_ -Scope Local
}

#   validation --------------------------------------------------------------
# ---------------------------------------------------------------------------
Class ValidatePocsLibStrict : IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] (Get-ValidatePocsLib)
    }
}

#   validation --------------------------------------------------------------
# ---------------------------------------------------------------------------
Class ValidatePocsLib : IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] ((Get-ValidatePocsLib) + "")
    }
}

#   validation --------------------------------------------------------------
# ---------------------------------------------------------------------------
Class ValidatePocsSectionStrict : IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] (Get-ValidateSection)
    }
}

#   validation --------------------------------------------------------------
# ---------------------------------------------------------------------------
Class ValidatePocsSection : IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        return [String[]] ((Get-ValidateSection) + "")
    }
}