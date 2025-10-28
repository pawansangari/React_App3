#!/bin/bash

# Build script for FastAPI + React app deployment to Databricks

set -e  # Exit on any error

echo "🚀 Building Hello World App for Databricks Deployment"
echo "=================================================="

# Step 1: Build Frontend
echo ""
echo "📦 Step 1: Building React Frontend..."
cd frontend

if [ ! -d "node_modules" ]; then
    echo "Installing npm dependencies..."
    npm install
fi

echo "Building production frontend..."
npm run build

if [ ! -d "build" ]; then
    echo "❌ Error: Frontend build failed!"
    exit 1
fi

echo "✅ Frontend build complete!"

# Step 2: Copy frontend build to backend
echo ""
echo "📋 Step 2: Copying frontend build to backend..."
cd ..
rm -rf src/my_project/frontend
cp -r frontend/build src/my_project/frontend
echo "✅ Frontend copied to backend!"

# Step 3: Build Python wheel
echo ""
echo "🐍 Step 3: Building Python wheel..."
uv build --wheel

if [ ! -d "dist" ]; then
    echo "❌ Error: Python wheel build failed!"
    exit 1
fi

echo "✅ Python wheel build complete!"

# Step 4: Summary
echo ""
echo "=================================================="
echo "✅ Build Complete!"
echo "=================================================="
echo ""
echo "📦 Artifacts created:"
echo "  - Frontend: src/my_project/frontend/"
echo "  - Wheel: dist/my_project-0.0.1-py3-none-any.whl"
echo ""
echo "Next steps:"
echo "  1. Validate bundle: databricks bundle validate"
echo "  2. Deploy to dev: databricks bundle deploy --target dev"
echo "  3. Deploy to prod: databricks bundle deploy --target prod"
echo ""

