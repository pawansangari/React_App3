# Deployment Guide - Hello World FastAPI + React App

This guide explains how to deploy the Hello World application to Databricks using Databricks Asset Bundles.

## Architecture

This application consists of:
- **Backend**: FastAPI application serving REST API endpoints
- **Frontend**: React application providing a modern UI
- **Deployment**: Databricks Asset Bundle for seamless deployment

## Prerequisites

1. **Databricks CLI** installed and configured
   ```bash
   pip install databricks-cli
   databricks configure
   ```

2. **Node.js and npm** (for frontend development)
   ```bash
   node --version  # Should be v16 or higher
   npm --version
   ```

3. **Python 3.11+** with uv or pip

## Local Development

### 1. Backend Development

Install Python dependencies:
```bash
# Using uv (recommended)
uv pip install -e ".[dev]"

# Or using pip
pip install -e ".[dev]"
```

Run the FastAPI server:
```bash
python src/my_project/main.py
```

The API will be available at http://localhost:8000

API Endpoints:
- `GET /` - Root endpoint
- `GET /api/health` - Health check
- `GET /api/hello` - Hello world message
- `GET /api/greet/{name}` - Personalized greeting

### 2. Frontend Development

Navigate to the frontend directory:
```bash
cd frontend
```

Install dependencies:
```bash
npm install
```

Start the development server:
```bash
npm start
```

The React app will be available at http://localhost:3000 and will proxy API requests to the backend.

## Building for Production

### 1. Build the Frontend

```bash
cd frontend
npm run build
```

This creates an optimized production build in `frontend/build/`.

### 2. Copy Frontend Build to Backend

```bash
cp -r frontend/build src/my_project/frontend/
```

This allows FastAPI to serve the React app as static files.

### 3. Build the Python Package

```bash
uv build --wheel
```

This creates a wheel file in the `dist/` directory.

## Deployment to Databricks

### Option 1: Deploy as Databricks App (Recommended for Apps with UI)

1. **Update databricks.yml** to include your workspace configuration

2. **Validate the bundle**:
   ```bash
   databricks bundle validate
   ```

3. **Deploy to dev environment**:
   ```bash
   databricks bundle deploy -t dev
   ```

4. **Deploy to production**:
   ```bash
   databricks bundle deploy -t prod
   ```

### Option 2: Deploy as Job/Workflow

For backend-only deployments or scheduled tasks, you can deploy as a Databricks job:

1. Update `resources/my_project.job.yml` to run the FastAPI app
2. Deploy using:
   ```bash
   databricks bundle deploy -t dev
   databricks bundle run my_project_job -t dev
   ```

## Environment Configuration

### Development (dev target)
- Mode: development
- Resources prefixed with `[dev username]`
- Schedules and triggers paused by default

### Production (prod target)
- Mode: production
- No resource prefixes
- Full scheduling enabled
- Requires explicit permissions

## Databricks App Configuration

The app is configured in `resources/my_project.app.yml`:
- Uses uvicorn to serve the FastAPI application
- Listens on port 8080 (Databricks standard)
- Includes both API and static frontend files

## Testing the Deployment

After deployment, test your app:

1. **Check API health**:
   ```bash
   curl https://<your-databricks-workspace>/apps/<app-name>/api/health
   ```

2. **Access the UI**:
   Open your browser to `https://<your-databricks-workspace>/apps/<app-name>/`

## Troubleshooting

### Frontend not loading
- Ensure `npm run build` was successful
- Verify frontend/build directory exists
- Check that frontend files were copied to src/my_project/frontend/

### API errors
- Check Databricks app logs
- Verify all dependencies are in pyproject.toml
- Ensure CORS is configured correctly

### Build failures
- Run `uv build --wheel` to check for Python package issues
- Verify all imports are correct
- Check that databricks.yml syntax is valid

## Project Structure

```
my_project/
├── databricks.yml              # Bundle configuration
├── pyproject.toml             # Python dependencies
├── src/
│   └── my_project/
│       ├── main.py            # FastAPI application
│       └── frontend/          # Built React app (after build)
├── frontend/                  # React source code
│   ├── package.json
│   ├── public/
│   └── src/
├── resources/
│   ├── my_project.app.yml     # App configuration
│   ├── my_project.job.yml     # Job configuration (if needed)
│   └── my_project.pipeline.yml # Pipeline configuration (if needed)
└── DEPLOYMENT.md              # This file
```

## Next Steps

1. Customize the API endpoints in `src/my_project/main.py`
2. Enhance the React UI in `frontend/src/App.js`
3. Add database connections or Spark integration as needed
4. Set up CI/CD pipeline for automated deployments
5. Configure monitoring and alerting

## Additional Resources

- [Databricks Asset Bundles Documentation](https://docs.databricks.com/dev-tools/bundles/index.html)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [React Documentation](https://react.dev/)
- [Databricks Apps Guide](https://docs.databricks.com/apps/index.html)

