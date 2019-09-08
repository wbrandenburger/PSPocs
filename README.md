# [PSPocs](https://github.com/wbrandenburger/PSPocs)

## Table of Contents

- [PSPocs](#pspocs)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Available Commands](#available-commands)
  - [Examples](#examples)
  - [Authors/Contributors](#authorscontributors)
    - [Author](#author)

## Description

The module PSPocs is a set of powershell extensions to papis, a highly extensible command-line based bibliography and document manager.

## Installation

PSPocs is published to the Powershell Gallery and can be installed as follows:

```powershell
Install-Module PSPocs
```

## Dependencies

The following PowerShell module will be automatically installed:

- [PSIni](https://github.com/lipkau/PsIni)

## Available Commands

| Command                  | Alias        | Description                                                                                 |
|--------------------------|--------------|---------------------------------------------------------------------------------------------|
| `Set-VirtualEnvLocation` | `cd-venv`    | Set the location of the predefined directory.                                               |
| `Install-VirtualEnv`     | `in-venv`    | Install or upgrade packages from command line or requirement files to virtual environments. |
| `Find-Python`            |              | Find a path, where a python distribution might located.                                     |
| `Get-Requirement`        |              | Create the requirement file of a specific virtual environment.                              |
| `Get-RequirementContent` |              | Get the content of a existing requirement file.                                             |
| `Get-VirtualEnv`         | `ls-venv`    | List all existing virtual environments in predefined directory.                             |
| `New-VirtualEnv`         | `mk-venv`    | Creates a virtual environment.                                                              |
| `Remove-VirtualEnv`      | `rm-venv`    | Removes a specific virtual environment in the predefined directory.                         |
| `Start-VirtualEnv`       | `start-venv` | Starts a specific virtual environment in the predefined directory.                          |
| `Stop-VirtualEnv`        | `stop-venv`  | Stops current running virtual environment.                                                  |

## Examples

## Authors/Contributors

### Author

- [Wolfgang Brandenburger](https://github.com/wbrandenburger)
