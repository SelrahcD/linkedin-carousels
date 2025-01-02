# Define directories
CONTENT_DIR = ./content
BUILD_DIR = ./build
THEMES_DIR = ./themes
MD_FILES := $(shell find ./content -name '*.md')
CARROUSELS := $(patsubst $(CONTENT_DIR)/%.md,$(BUILD_DIR)/%,$(MD_FILES))

all: $(CARROUSELS)

one:
	@selected_file=$$(find $(CONTENT_DIR) -type f -name "*.md" | fzf); \
	if [ -z "$$selected_file" ]; then \
		echo "No file selected."; \
		exit 1; \
	fi; \
	filename=$$(basename -- "$$selected_file"); \
	filename_without_ext=$${filename%.*}; \
	make $(BUILD_DIR)/$${filename_without_ext}


$(BUILD_DIR)/%: $(CONTENT_DIR)/%.md
	@mkdir -p $@
	npx marp --theme-set $(THEMES_DIR)/ --pdf --allow-local-files --output $@/$(subst .md,.pdf,$(notdir $<)) -- $<

clean:
	@rm -rf $(BUILD_DIR)/*.pdf
	@echo "Build directory cleaned."

.PHONY: all build-pdf clean one