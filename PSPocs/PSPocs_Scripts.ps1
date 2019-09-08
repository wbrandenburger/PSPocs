# ===========================================================================
#   PSPocs_Scripts.psm1 -----------------------------------------------------
# ===========================================================================

#   import ------------------------------------------------------------------
# ---------------------------------------------------------------------------
using namespace System.Management.Automation

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