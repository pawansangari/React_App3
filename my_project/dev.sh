#!/bin/bash

# Development script to run backend and frontend concurrently

echo "🚀 Starting Development Environment"
echo "===================================="
echo ""
echo "Backend will run on: http://localhost:8000"
echo "Frontend will run on: http://localhost:3000"
echo ""
echo "Press Ctrl+C to stop both servers"
echo ""

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "Stopping servers..."
    kill $(jobs -p) 2>/dev/null
    exit 0
}

trap cleanup EXIT INT TERM

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

