# Usage
Set the name of the project in `Makefile` in the variable `PROJECT_NAME`.

Add the dependencies's includes in `deps/include` directory.

Add the dependencies's library in `deps/libs` directory.

Set `BUILD_PARAMS` with extra params used during linking. Can be used to link dependencies.

## `setup`
Run to initializ empty project.
```bash
$ make setup
```

## `compile`
Run to compile the project.
```bash
$ make compile
```

## `build`
Run to link and build the executable. Will create a executable name as `{PROJECT_NAME}.o` in `build` directory.
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
