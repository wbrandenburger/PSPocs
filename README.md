# [PSPocs](https://github.com/wbrandenburger/PSPocs)

## Table of Contents

- [PSPocs](#pspocs)
  - [Table of Contents](#table-of-contents)
  - [General](#general)
  - [Description](#description)
  - [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Available Commands](#available-commands)
  - [Examples](#examples)
  - [Authors/Contributors](#authorscontributors)
    - [Author](#author)

## General

The module PSPocs is in an experimental status and will be developed to achieve a stable version as fast as possible. The documentation of several functions has to be customized, due to the last changes.

## Description

The module PSPocs is a wrapper for applying papis in windows with powershell. [Papis](https://github.com/papis/papis) is a highly extensible command-line based bibliography and document manager written in Python.

## Installation

PSPocs is published to the Powershell Gallery and can be installed as follows:

```powershell
Install-Module PSPocs
```

To activate PSPocs and its autocompletion there is the need to dotsource in shell or in the local profile the output of `ActivatePocsAutocompletion`:

```powershell
. (ActivatePocsAutocompletion) # or in short '. (activate-pocs)'
```

If loading the classes for autocompletion of PSPocs function parameters, corresponding classes for required module PSVirtual are also be loaded.

## Dependencies

The following PowerShell modules will be automatically installed:

- [PSIni](https://github.com/lipkau/PsIni)
- [PSVirtualEnv](https://github.com/wbrandenburger/PSVirtualEnv)

## Available Commands

| Command               | Alias     | Description                                                                                     |
|-----------------------|-----------|-------------------------------------------------------------------------------------------------|
| `Edit-PocsLib`        | `ed-venv` | Edit existing literature and document libraries.                                                |
| `Get-PocsLib`         | `ls-venv` | Get existing literature and document libraries directory.                                       |
| `New-PocsLib`         | `mk-venv` | Add a literature and document library and store it in package's configuration file.             |
| `Remove-PocsLib`      | `rm-venv` | Remove existing literature and document libraries.                                              |
| `Repair-PocsLib`      | `rp-pocs` | Reverse changes to literature and document libraries in current powershell session.             |
| `Start-PocsLib`       | `sa-pocs` | Starts a specific papis library defined in package's configuration file.                        |
| `Start-PocsProcess`   | `sa-lib`  | Starts a specific papis library defined in package's configuration file.                        |
| `Stop-PocsLib`        | `sp-pocs` | Stops current running papis library.                                                            |
| `Update-PocsLib`      | `ud-pocs` | Update content of literature and document file while reading from package's configuration file. |
| `Write-PocsLibStatus` |           | Function to use in extensions for prompt, writing status of current running papis library.      |

## Examples

## Authors/Contributors

### Author

- [Wolfgang Brandenburger](https://github.com/wbrandenburger)
