#!/bin/bash
# Create local research repository structure

set -e

REPO_NAME="$1"

if [ -z "$REPO_NAME" ]; then
  echo "Usage: $0 <repo-name>"
  echo "Example: $0 research-lmcache"
  exit 1
fi

RESEARCH_DIR="$HOME/work/sources/researchs"
REPO_PATH="$RESEARCH_DIR/$REPO_NAME"

# Create research directory if it doesn't exist
mkdir -p "$RESEARCH_DIR"

# Check if repo already exists
if [ -d "$REPO_PATH" ]; then
  echo "Directory already exists: $REPO_PATH"
  if [ "$(ls -A "$REPO_PATH")" ]; then
    echo "WARNING: Directory is not empty"
    echo "Please backup or remove existing content"
    exit 1
  else
    echo "Directory exists but is empty. Proceeding..."
  fi
else
  echo "Creating research repository: $REPO_PATH"
  mkdir -p "$REPO_PATH"
fi

cd "$REPO_PATH"

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
  echo "Initializing git repository..."
  git init
  git branch -M main
fi

# Create initial structure
mkdir -p notes

# Create placeholder README
if [ ! -f "README.md" ]; then
  cat > README.md <<EOF
# $(echo "$REPO_NAME" | sed 's/research-//' | tr '-' ' ' | sed 's/.*/\u&/')

**Multi-spectrum technical research following Probe methodology.**

---

## Status

Research in progress...

---

## Spectra Coverage

- [ ] Fundamentals
- [ ] Architecture
- [ ] Technical Deep-Dive
- [ ] Academic Research
- [ ] Integration
- [ ] Performance
- [ ] Use Cases
- [ ] Applicability
- [ ] Implementation
- [ ] Critical FAQ

---

**Research conducted using Probe** - Multi-spectrum research architecture.
EOF
fi

# Create .gitignore
if [ ! -f ".gitignore" ]; then
  cat > .gitignore <<EOF
# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Temporary notes
notes/scratch*
notes/temp*

# Python
__pycache__/
*.py[cod]
*$py.class
.venv/
venv/

# Node
node_modules/
EOF
fi

echo "Research repository created: $REPO_PATH"
echo ""
echo "Structure:"
tree -L 2 "$REPO_PATH" 2>/dev/null || ls -la "$REPO_PATH"
