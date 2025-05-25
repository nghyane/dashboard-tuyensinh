#!/bin/bash

# Script to remove validateLicense implementation from @nuxt/ui-pro

set -e

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "❌ node_modules not found. Run from project root."
    exit 1
fi

# Define target directory
UI_PRO_DIR="node_modules/@nuxt/ui-pro/dist/shared"

if [ ! -d "$UI_PRO_DIR" ]; then
    echo "⚠️  @nuxt/ui-pro not found. Skipping."
    exit 0
fi

# Find ui-pro.*.mjs files
UI_PRO_FILES=$(find "$UI_PRO_DIR" -name "ui-pro.*.mjs" 2>/dev/null || true)

if [ -z "$UI_PRO_FILES" ]; then
    echo "⚠️  No ui-pro.*.mjs files found."
    exit 0
fi

# Process each file
for file in $UI_PRO_FILES; do
    if grep -q "async function validateLicense" "$file"; then
        echo "🔧 Removing license validation from: $file"

        # Replace validateLicense function directly
        sed -i.tmp '/^async function validateLicense/,/^}$/c\
async function validateLicense(opts) {\
  return Promise.resolve();\
}' "$file"

        # Remove temp file
        rm -f "${file}.tmp"

        echo "✅ License validation removed"
    fi
done

echo "🎉 Completed! Run 'npm install' to restore if needed."
