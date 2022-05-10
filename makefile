.PHONY : build

SWIFT_COMPILER=/usr/bin/swiftc

APP_BUNDLE = VeryCoolApp.app

# Get the iOS local SDK path to run on simulator.
SDK := $(shell xcrun --sdk iphonesimulator --show-sdk-path)

TARGET = "x86_64-apple-ios15.2-simulator"

IBTOOL = /usr/bin/ibtool

build:
	rm -rf $(APP_BUNDLE)
	mkdir $(APP_BUNDLE)

	# The Info.plist is the file that contains an information property list.
	# Ths file is a key value pair and inform to the system how see the bundle information.
	cp Info.plist $(APP_BUNDLE)/Info.plist

	# The executable file is the main entry point (Match-o).
	# If the project have more than one swift file the entry point should be the file "main.swift" or notation "@main".
	# Important, the compiled file must have the same name indicated at Info.plist (CFBundleExecutable)
	# We cannot only build the swift files because the app uses UIKit that depends on iOS SDK.
	# $(SWIFT_COMPILER) *.swift -o $(APP_BUNDLE)/VeryCoolApp

	# To allow UIKit import we need the iOS SDK
	# $(SWIFT_COMPILER) *.swift -o $(APP_BUNDLE)/VeryCoolApp -sdk $(SDK)

	# Calls the VeryCoolLibrary compilation script
	cd VeryCoolLibrary && make build_lib

	# To link the lib in the main project we use Id, by adding the flag Xlinker to the compiler.
	# After link the lib we also need to indicate to the compiler the interface file for the lib.
	# To do that we add the flag -I indicating the lib source, by default the compiler will look for the file .swiftmodule.

	# If we dont specify the target, it will assume its for MacOS.
	$(SWIFT_COMPILER) *.swift \
		-o $(APP_BUNDLE)/VeryCoolApp \
		-sdk $(SDK) \
		-target $(TARGET) \
		-Xlinker ./VeryCoolLibrary/libVeryCoolLibrary.a \
		-I ./VeryCoolLibrary/

	# Compile xibs to runtime nib 
	$(IBTOOL) SomeView.xib --compile $(APP_BUNDLE)/SomeView.nib

