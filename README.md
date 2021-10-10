# cpp-starter-kit
A simple attempt at making building c++ projects easier.

# Features
- Uses [conan.io](https://conan.io/) to manage dependencies.
- Uses [make](https://www.gnu.org/software/make/) as build system.
- Uses [gtest](https://github.com/google/googletest) for unit tests.

# Usage
- Clone the repository.
- Update the name and description of the project in the file `ProjectInfo.mk`.
- Add any build parameters in `BuildOptions.mk`.
- Add dependencies in `conanfile.py`.

## `setup`
Install dependencies
```bash
$ make setup
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

## `test`
Runs the unit tests.
```bash
$ make test
```

## `clean`
Run to clean compile artifacts.
```bash
$ make clean
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
> Note: Use [conan](https://conan.io/) to install dependencies if possible.

## libs
- Stores the static build of library of external dependencies
```
libs
|--> Debug
     |-> Linux
         |-> x86
             |-> Dependency1.lib
             |-> Dependency2.lib
         |-> x64
             |-> Dependency1.lib
             |-> Dependency2.lib
     |-> Win
         ...
     |-> MacOs
         ...
|--> Release
     |-> Linux
         ...
     |-> Win
         ...
     |-> MacOs
         ...
```
> Note: Use [conan](https://conan.io/) to install dependencies if possible.

## src
- Source files for the project.

# How to install a dependency?
## Avaliable as conan package?
- If available as a conan package, add the package in `conanfile.py`.

## Header Only?
- Add the headers in the `includes` directory.

## Prebuilt binary and headers available?
- Add headers to `includes` directory.
- Add prebuilt binaries to `libs` directory.
- Update `CCFLAGS`/`CFLAGS` in `BuildOptions.mk` to link the library.

## Need to build manually?
- Build the dependency following the instruction for the dependency.
- Copy the binaries to `libs` directory.
- Update `CCFLAGS`/`CFLAGS` in `BuildOptions.mk` to link the library.
- Copy the headers to `includes` directory.
