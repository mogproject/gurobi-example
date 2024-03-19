# Gurobi Example

Minimum example of a C++ project with Gurobi.

We want to use GCC 13 on Mac.

- (1) Install gcc 13 using Homebrew: `brew install gcc@13`
  - Now, `which c++-13` should output `/opt/homebrew/bin/c++-13`.
- (2) Install Gurobi Optimizer version 11.0.1.
- (3) Recompile `libgurobi_c++.a` using GCC.
  - `cd /Library/gurobi1101/macos_universal2/src/build`
  - Rewrite `Makefile`: replace `C++ = g++` with `C++ = g++-13`.
  - `make`
  - `sudo cp -i libgurobi_c++.a ../../lib/`

Now, we are ready to compile the program.

- (4) Run `make` in this directory.
  - Executable `build/Release/mip` will be created.
  - We add the `-fopenmp` option to make sure that we are not using `clang`.
- (5) Run `build/Release/mip`.
  - This should output the following in the end.

```
x 1
y 0
z 1
Obj: 3
```
