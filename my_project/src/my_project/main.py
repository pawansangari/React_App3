from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import os

app = FastAPI(title="Hello World API", version="1.0.0")

# Configure CORS for local development and Databricks deployment
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify exact origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    """Root endpoint"""
    return {"message": "Hello World from FastAPI!"}

@app.get("/api/health")
async def health_check():
    """Health check endpoint"""
    return {"status": "healthy", "message": "API is running"}

@app.get("/api/hello")
async def hello():
    """Hello world endpoint"""
    return {
        "message": "Hello World!",
        "description": "This is a decoupled FastAPI + React app deployed on Databricks",
        "version": "1.0.0"
    }

@app.get("/api/greet/{name}")
async def greet(name: str):
    """Personalized greeting endpoint"""
    return {"message": f"Hello, {name}!"}

# Serve React static files in production
static_dir = os.path.join(os.path.dirname(__file__), "frontend", "build")
if os.path.exists(static_dir):
    app.mount("/static", StaticFiles(directory=os.path.join(static_dir, "static")), name="static")
    
    @app.get("/{full_path:path}")
    async def serve_react_app(full_path: str):
        """Serve React app for all other routes"""
        if full_path.startswith("api/"):
            return {"error": "API endpoint not found"}
        index_file = os.path.join(static_dir, "index.html")
        if os.path.exists(index_file):
            return FileResponse(index_file)
        return {"message": "Frontend not built yet"}


def main():
    """Entry point for running the app locally"""
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)


if __name__ == "__main__":
    main()
