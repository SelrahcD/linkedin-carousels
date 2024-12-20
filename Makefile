# Define directories
CONTENT_DIR = ./content
BUILD_DIR = ./build
THEMES_DIR = ./themes

# The default target
all: build-pdf

%.pdf: ./content/%.md
	npx marp --theme-set ./themes/ --pdf --allow-local-files --output build/$@ -- $<


clean:
	@rm -rf $(BUILD_DIR)/*.pdf
	@echo "Build directory cleaned."

.PHONY: all build-pdf clean