# Change Log

## [0.4.7](https://github.com/wbrandenburger/PSPocs/tree/0.4.7) (2019-09-22)

**Implemented enhancements:**

- Added opportunity for online and offline installation of package `papis` to function `Repair-Papis`.

## [0.4.6](https://github.com/wbrandenburger/PSPocs/tree/0.4.6) (2019-09-21)

**Implemented enhancements:**

- Added option `Wait/Update` to function `Edit-PocsLibrary`
- Added function `Repair-TestEnvironment` for validation and setting of a papis environment.

**Fixed bugs:**

- If the main papis configuration file can not be found, a valid configuration file will be set.

## [0.4.4](https://github.com/wbrandenburger/PSPocs/tree/0.4.4) (2019-09-17)

**Implemented enhancements:**

- Added installation of papis from fork
- Added configuration file
- Added fields `virtual-env` and `papis-packages` to configuration file for installing papis
- Added fields `default-editor` and `editor-arguments`to configuration file for editing config files
- Added functions `Get-PocsConfig` and `Edit-PocsConfig`

## [0.4.3](https://github.com/wbrandenburger/PSPocs/tree/0.4.3) (2019-09-15)

**Fixed bugs:**

- Abort initialization of module, if configuration file for papis cannot be found.

## [0.4.2](https://github.com/wbrandenburger/PSPocs/tree/0.4.2) (2019-09-15)

**Implemented enhancements:**

- Stop virtual environment after start process with papis in `Start-PocsProcess`

## [0.4.1](https://github.com/wbrandenburger/PSPocs/tree/0.4.1) (2019-09-15)

**Implemented enhancements:**

- Referenced fields in configuration files with a reference to another fields can be evaluated

## [0.4.0](https://github.com/wbrandenburger/PSPocs/tree/0.4.0) (2019-09-12)

**Implemented enhancements:**

- Added use of module PSVirtualEnv

**Fixed bugs:**

- Activation of autocompletion
- Refactoring of core functionality
