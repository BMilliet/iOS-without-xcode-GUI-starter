.PHONY : build_lib

SWIFT_COMPILER=/usr/bin/swiftc
SDK := $(shell xcrun --sdk iphonesimulator --show-sdk-path)
TARGET = "x86_64-apple-ios15.2-simulator"

LIB_NAME = VeryCoolLibrary

build_lib:
	# Compile VeryCoolLibrary
	# Beyond the previous main app compilation we can see more flags being passed to swiftc.
	# emit-library should generate a library as result
	# static marks it as static (the default is dynamic)
	# emit-module should make a entry point as .swiftmodule file allowing it to be imported.
	# module-name name the final package.

	$(SWIFT_COMPILER) VeryCoolLibrary.swift \
	-sdk $(SDK) \
	-target $(TARGET) \
	-emit-library \
	-static \
	-emit-module \
	-module-name $(LIB_NAME)
