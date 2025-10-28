#!/bin/bash

# Development script to run backend and frontend concurrently

echo "🚀 Starting Development Environment"
echo "===================================="
echo ""

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "Stopping servers..."
    kill $(jobs -p) 2>/dev/null
    exit 0
}

trap cleanup EXIT INT TERM

# Check and install Python dependencies
echo "Checking Python dependencies..."
if ! python -c "import fastapi" 2>/dev/null; then
    echo "Installing Python dependencies..."
    uv pip install -e ".[dev]" || pip install -e ".[dev]"
fi

# Check and install Node dependencies
echo "Checking Node.js dependencies..."
if [ ! -d "frontend/node_modules" ]; then
    echo "📦 Installing npm packages (this may take a minute)..."
    cd frontend
    npm install
    cd ..
fi

echo ""
echo "Backend will run on: http://localhost:8000"
echo "Frontend will run on: http://localhost:3000"
echo ""
echo "Press Ctrl+C to stop both servers"
echo ""

# Start backend in background
echo "Starting FastAPI backend..."
python src/my_project/main.py &
BACKEND_PID=$!

# Wait a bit for backend to start
sleep 2

# Start frontend in background
echo "Starting React frontend..."
cd frontend
npm start &
FRONTEND_PID=$!

# Wait for both processes
wait $BACKEND_PID $FRONTEND_PID

