# cpp-starter-kit
A simple attempt at making building c++ projects easier.

# Usage
- Clone the repository.
- Update the name and description of the project in the file `ProjectInfo.mk`.
- Add any build parameters in `BuildOptions.mk`.

## `setup-vendor`
Fetch the submodules.
```bash
$ make setup-vendor
```

## `compile`
Run to compile the project.
```bash
$ make compile
```

## `build`
Run to link and build the executable. Will create a executable name as `{EXECUTABLE_NAME}` set in `BuildOptions.mk`.
```bash
$ make build
```
Or just
```bash
$ make
```

## `run`
Run to execute the project.
```bash
$ make run
```

## `clean`
Run to clean compile artifacts.
```bash
$ make clean
```

## `submodule`
Add git repository as sub modules for the project.
```bash
$ make submodule module=upstream_link_for_module
```

# Project Structure
```
\
|--> includes
|--> libs
|--> src
|--> vendor
```

## includes
- Contains the header files for external dependencies.
```
includes
|--> Dependency1 
|--> Dependency2
.
.
.
|--> DependencyN
```
> **Why not just use `vendor`?**
> The concept here is `vendor` contains the sub modules available as git repository. So, for any other dependency you have that don't exists as a git repository or it's just a header only library `includes` can be used.

## libs
- Stores the static build of library of external dependencies
```
libs
|--> Debug
     |-> Win
         |-> x86
             |-> Dependency1.lib
             |-> Dependency2.lib
         |-> x64
             |-> Dependency1.lib
             |-> Dependency2.lib
     |-> Linux
         |-> x86
             |-> Dependency1.lib
             |-> Dependency2.lib
         |-> x64
             |-> Dependency1.lib
             |-> Dependency2.lib
     |-> MacOs
         |-> x86
             |-> Dependency1.lib
             |-> Dependency2.lib
         |-> x64
             |-> Dependency1.lib
             |-> Dependency2.lib
|--> Release
     |-> Win
         |-> x86
             |-> Dependency1.lib
             |-> Dependency2.lib
         |-> x64
             |-> Dependency1.lib
             |-> Dependency2.lib
     |-> Linux
         |-> x86
             |-> Dependency1.lib
             |-> Dependency2.lib
         |-> x64
             |-> Dependency1.lib
             |-> Dependency2.lib
     |-> MacOs
         |-> x86
             |-> Dependency1.lib
             |-> Dependency2.lib
         |-> x64
             |-> Dependency1.lib
             |-> Dependency2.lib
```

## src
- Source files for the project.

## vendor
- Stores sub modules used in the project.

# How to install a dependency?
## Header Only?
- If available as a git repository, add the repository as sub module. And update the `ADDITIONAL_INCLUDES` in `BuildOptions.mk` and `.vscode/c_cpp_properties.json` (for Intellisense)
- If not available as a git repository, add the headers in the `includes` directory.

## Prebuilt binary and headers available?
- Add headers to `includes` directory.
- Add prebuilt binaries to `libs` directory.
- Update `CCFLAGS`/`CFLAGS` in `BuildOptions.mk` to link the library.

## Need to build manually?
- Add the dependency as sub module.
- Build the sub module following the instruction for the sub module.
- Copy the binaries to `libs` directory.
- Update `CCFLAGS`/`CFLAGS` in `BuildOptions.mk` to link the library.
- If headers are provided separately in repository, update the `ADDITIONAL_INCLUDES` in `BuildOptions.mk` and `.vscode/c_cpp_properties.json` (for Intellisense) to add the headers for the sub modules from `vendor`.
- Else, copy the headers to `includes` directory.
