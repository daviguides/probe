.PHONY: help dev prod status

# Probe - Multi-Spectrum Research Architecture
# Makefile for dev/prod reference toggling

help:
	@echo "Probe - Multi-Spectrum Research Architecture"
	@echo ""
	@echo "Commands:"
	@echo "  make dev     Convert @ references to relative paths (for development)"
	@echo "  make prod    Convert @ references to absolute paths (for production)"
	@echo "  make status  Show current reference mode"
	@echo ""
	@echo "Usage:"
	@echo "  - Development: make dev (use relative paths for editing)"
	@echo "  - Production: make prod (use absolute paths for plugin usage)"

dev:
	@echo "Converting to development mode (relative @ references)..."
	@find probe commands agents -name "*.md" -type f -exec sed -i.bak 's|@~/.claude/probe/|@./probe/|g' {} \;
	@find probe commands agents -name "*.md" -type f -exec sed -i.bak 's|@/Users/[^/]*/\.claude/probe/|@./probe/|g' {} \;
	@find . -name "*.bak" -delete
	@echo "✓ Converted to relative @ references (development mode)"

prod:
	@echo "Converting to production mode (absolute @ references)..."
	@find probe commands agents -name "*.md" -type f -exec sed -i.bak 's|@\./probe/|@~/.claude/probe/|g' {} \;
	@find . -name "*.bak" -delete
	@echo "✓ Converted to absolute @ references (production mode)"

status:
	@echo "Checking reference mode..."
	@if grep -q "@~/.claude/probe/" probe/prompts/load-research-context.md 2>/dev/null; then \
		echo "✓ Production mode (absolute @ references)"; \
	elif grep -q "@\./probe/" probe/prompts/load-research-context.md 2>/dev/null; then \
		echo "✓ Development mode (relative @ references)"; \
	else \
		echo "⚠ Unknown mode or file not found"; \
	fi
