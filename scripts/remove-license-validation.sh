#!/bin/sh

# Script to remove validateLicense implementation from @nuxt/ui-pro

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
for file in "$UI_PRO_DIR"/ui-pro.*.mjs; do
    if [ ! -f "$file" ]; then
        echo "⚠️  No ui-pro.*.mjs files found."
        exit 0
    fi

    if grep -q "async function validateLicense" "$file"; then
        echo "🔧 Removing license validation from: $file"

        # Create a temporary file
        temp_file="${file}.tmp"
        
        # Process the file using sed with POSIX-compliant syntax
        sed 's/async function validateLicense[^}]*}/async function validateLicense(opts) {\
  return Promise.resolve();\
}/' "$file" > "$temp_file"
        
        # Replace original with temporary file
        mv "$temp_file" "$file"

        echo "✅ License validation removed"
    fi
done

echo "🎉 Completed! Run 'npm install' to restore if needed."