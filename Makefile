# Define directories
CONTENT_DIR = ./content
BUILD_DIR = ./build
THEMES_DIR = ./themes
MD_FILES := $(shell find ./content -name '*.md')
CARROUSELS_PDF := $(patsubst $(CONTENT_DIR)/%.md,%.pdf,$(MD_FILES))

all: $(CARROUSELS_PDF)

one:
	@selected_file=$$(find $(CONTENT_DIR) -type f -name "*.md" | fzf); \
	if [ -z "$$selected_file" ]; then \
		echo "No file selected."; \
		exit 1; \
	fi; \
	filename=$$(basename -- "$$selected_file"); \
	filename_without_ext=$${filename%.*}; \
	make $${filename_without_ext}.pdf


%.pdf: $(CONTENT_DIR)/%.md
	@mkdir -p $(BUILD_DIR)
	npx marp --theme-set $(THEMES_DIR)/ --pdf --allow-local-files --output $(BUILD_DIR)/$@ -- $<

clean:
	@rm -rf $(BUILD_DIR)/*.pdf
	@echo "Build directory cleaned."

.PHONY: all build-pdf clean one