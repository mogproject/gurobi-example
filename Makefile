RM = /bin/rm
MV = /bin/mv
CP = /bin/cp

# Use gcc 13 on Mac
ifneq ("$(wildcard /opt/homebrew/bin/g++-13)","")
    export CC=/opt/homebrew/bin/gcc-13
    export CXX=/opt/homebrew/bin/g++-13
endif

# Gurobi settings
ifndef GUROBI_HOME
    # Mac Gurobi v11.0.1
    ifneq ("$(wildcard /Library/gurobi1101/macos_universal2)","")
        export GUROBI_HOME=/Library/gurobi1101/macos_universal2
    else
        $(error GUROBI_HOME is not set)
    endif
endif

CMAKE=cmake
CMAKE_OPTS=-DCMAKE_C_COMPILER=$(CC) -DCMAKE_CXX_COMPILER=$(CXX)

SRC_CPP=src/main/cpp
PROJ_DIR=$(PWD)
BUILD_DIR=$(PROJ_DIR)/build

build:
	cd $(SRC_CPP) && $(CMAKE) -DCMAKE_BUILD_TYPE=Release -S . -B "$(BUILD_DIR)/Release" $(CMAKE_OPTS)
	cd $(SRC_CPP) && $(CMAKE) --build "$(BUILD_DIR)/Release"
	@echo "Created: build/Release/mip"

clean:
	@echo "Cleaning..."
	@$(RM) -rf build/*
	@echo "Cleaning done."

.PHONY: build clean
