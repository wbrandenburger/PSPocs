# [PSPocs](https://github.com/wbrandenburger/PSPocs)

## Table of Contents

- [PSPocs](#PSPocs)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
    - [Origin](#origin)
  - [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Settings](#settings)
  - [Available Commands](#available-commands)
  - [Examples](#examples)
    - [Creating virtual environments](#creating-virtual-environments)
  - [Authors/Contributors](#authorscontributors)
    - [Author](#author)

## Description

### Origin

This module is an extension of [virtualenvwrapper-powershell](https://github.com/regisf/virtualenvwrapper-powershell) and adds more functionality

## Installation

PSPocs is published to the Powershell Gallery and can be installed as follows:

```powershell
Install-Module PSPocs
```

## Dependencies

The following PowerShell module will be automatically installed:

- [PSIni](https://github.com/lipkau/PsIni)

## Settings

PSPocs creates automatically a configuration file in folder `%USERPRFOFILE%\PSPocs`. Additionally, PSPocs search for configuration directories in environment variable `%XDG_CONFIG_HOME%` and `XDG_CONFIG_DIRS`. In configuration file the working directory of a python distribution and an user defined folder for virtual environment can be specified.

```ini
[settings]

; default path where virtual environments are located
venv-work-dir = "A:\VirtualEnv"

; config path of virtual environments
venv-config-dir =  "A:\VirtualEnv\.config"

; default download path for python packages
venv-local-dir =  "A:\VirtualEnv\.temp"

; default python distribution
python = "C:\Python\Python37\python.exe"
```

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

### Creating virtual environments

Creates a virtual environment in the predefined directory and install via a requirements file project related packages. All available requirement files can be accessed by autocompletion.

```log
  PS C:\> New-VirtualEnv -Name venv -Requirement \requirements.txt

  [PSPocs]::PROCESS: Creating new virtual environment 'venv'.
  New python executable in C:\Users\User\PSPocs\venv\Scripts\python.exe
  Installing setuptools, pip, wheel...
  done.

  [PSPocs]::SUCCESS: Virtual environment 'C:\Users\User\PSPocs\venv' was created.

  [PSPocs]::PROCESS: Try to install missing packages from requirement file 'C:\Users\User\PSPocs\.require\requirements.txt'.

  [PSPocs]::SUCCESS: Packages from requirement file 'C:\Users\User\PSPocs\.require\requirements.txt' were installed.


  Name       Version Latest
  ----       ------- ------
  package    version
  pip        19.2.3
  setuptools 41.2.0
  wheel      0.33.6
```

## Authors/Contributors

### Author

- [Wolfgang Brandenburger](https://github.com/wbrandenburger)
