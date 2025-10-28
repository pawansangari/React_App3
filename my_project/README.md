# Hello World - FastAPI + React on Databricks

A simple, decoupled FastAPI + React application designed for deployment on Databricks using Databricks Asset Bundles.

## Overview

This project demonstrates:
- **Backend**: FastAPI REST API with health check and greeting endpoints
- **Frontend**: Modern React UI with beautiful gradient design
- **Deployment**: Databricks Asset Bundle for seamless deployment to Databricks

## Features

- ✨ Modern, responsive UI built with React 18
- 🚀 Fast and efficient FastAPI backend
- 🎨 Beautiful gradient design with smooth animations
- 📦 Easy deployment via Databricks Asset Bundles
- 🔌 Decoupled architecture - frontend and backend can be developed independently
- 💡 Simple "Hello World" example that's easy to extend

## Quick Start

### Prerequisites

1. **Python 3.11+** and **UV** (Python package installer)
   ```bash
   # Install UV
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

2. **Node.js 16+** and **npm** (for frontend)
   ```bash
   node --version  # Should be v16 or higher
   npm --version
   ```

3. **Databricks CLI**
   ```bash
   pip install databricks-cli
   databricks configure
   ```

### Local Development

#### 1. Backend (FastAPI)

Install dependencies and run the backend:
```bash
# Install Python dependencies
uv pip install -e ".[dev]"

# Run the FastAPI server
python src/my_project/main.py
```

The API will be available at http://localhost:8000

Test the API:
```bash
curl http://localhost:8000/api/hello
curl http://localhost:8000/api/greet/YourName
```

#### 2. Frontend (React)

In a new terminal, navigate to the frontend directory:
```bash
cd frontend

# Install dependencies
npm install

# Start the development server
npm start
```

The React app will open at http://localhost:3000

### Building for Production

#### 1. Build the Frontend
```bash
cd frontend
npm run build
```

#### 2. Copy Frontend to Backend
```bash
# From the project root
cp -r frontend/build src/my_project/frontend/
```

#### 3. Build Python Package
```bash
uv build --wheel
```

### Deployment to Databricks

#### Deploy to Development
```bash
databricks bundle validate
databricks bundle deploy --target dev
```

#### Deploy to Production
```bash
databricks bundle deploy --target prod
```

After deployment, access your app at:
```
https://<your-databricks-workspace>/apps/hello_world_app/
```

## Project Structure

```
my_project/
├── src/my_project/
│   └── main.py              # FastAPI backend
├── frontend/                # React application
│   ├── src/
│   │   ├── App.js          # Main React component
│   │   ├── App.css         # Styles
│   │   └── index.js        # Entry point
│   ├── public/
│   └── package.json
├── resources/
│   ├── my_project.app.yml   # Databricks App config
│   ├── my_project.job.yml   # Job config
│   └── my_project.pipeline.yml
├── databricks.yml           # Bundle configuration
├── pyproject.toml          # Python dependencies
├── DEPLOYMENT.md           # Detailed deployment guide
└── README.md               # This file
```

## API Endpoints

- `GET /` - Root endpoint with welcome message
- `GET /api/health` - Health check endpoint
- `GET /api/hello` - Hello world with app description
- `GET /api/greet/{name}` - Personalized greeting

## Development Tips

1. **Hot Reload**: Both FastAPI and React support hot reload during development
2. **API Proxy**: The React dev server proxies `/api/*` requests to the FastAPI backend
3. **CORS**: CORS is configured in FastAPI for local development
4. **Testing**: Test the backend API independently before building the frontend

## Extending the Application

To add new features:

1. **Add Backend Endpoints**: Edit `src/my_project/main.py`
2. **Update Frontend UI**: Edit `frontend/src/App.js`
3. **Add Databricks Features**: 
   - Connect to Databricks tables
   - Use Spark for data processing
   - Add authentication and authorization
   - Integrate with Unity Catalog

## Documentation

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md)

For more information:
- [Databricks Asset Bundles Documentation](https://docs.databricks.com/dev-tools/bundles/index.html)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [React Documentation](https://react.dev/)
