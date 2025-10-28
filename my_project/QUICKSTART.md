# Quick Start Guide

Get your FastAPI + React app running in minutes!

## 1. Install Prerequisites

### Python & UV
```bash
# Install UV (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Node.js & npm
```bash
# Check if you have Node.js (need v16+)
node --version
npm --version

# If not installed, download from: https://nodejs.org/
```

## 2. Local Development (Easiest Way)

### Option A: Use the Dev Script (Recommended)
```bash
# This starts both backend and frontend automatically
./dev.sh
```

### Option B: Manual Start
```bash
# Terminal 1 - Backend
python src/my_project/main.py

# Terminal 2 - Frontend
cd frontend
npm install
npm start
```

Visit http://localhost:3000 to see your app! 🎉

## 3. Deploy to Databricks

### First Time Setup
```bash
# Install Databricks CLI
pip install databricks-cli

# Configure with your workspace
databricks configure
```

### Build & Deploy
```bash
# Build everything
./build.sh

# Validate configuration
databricks bundle validate

# Deploy to dev environment
databricks bundle deploy --target dev
```

## Testing Your Deployment

### Test API Endpoints
```bash
# Health check
curl http://localhost:8000/api/health

# Hello endpoint
curl http://localhost:8000/api/hello

# Personalized greeting
curl http://localhost:8000/api/greet/YourName
```

### Test Frontend
Open http://localhost:3000 in your browser:
- You should see a beautiful gradient background
- The "Hello World!" message from the API
- A form to enter your name and get a personalized greeting

## Troubleshooting

### Frontend won't start
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
npm start
```

### Backend errors
```bash
# Reinstall Python dependencies
uv pip install -e ".[dev]"

# Try running again
python src/my_project/main.py
```

### Build script fails
```bash
# Make sure scripts are executable
chmod +x build.sh dev.sh

# Check Node.js version (need v16+)
node --version

# Check UV is installed
uv --version
```

## Next Steps

1. ✏️ **Customize the API**: Edit `src/my_project/main.py`
2. 🎨 **Update the UI**: Edit `frontend/src/App.js` and `frontend/src/App.css`
3. 🗄️ **Add Database**: Connect to Databricks tables or Unity Catalog
4. 🔒 **Add Auth**: Implement authentication and authorization
5. 📊 **Add Analytics**: Integrate with Databricks notebooks and dashboards

## Project Structure

```
my_project/
├── src/my_project/main.py    # Your FastAPI backend
├── frontend/src/              # Your React frontend
│   ├── App.js                # Main React component
│   ├── App.css               # Styles
│   └── index.js              # Entry point
├── build.sh                  # Build script
├── dev.sh                    # Development script
└── README.md                 # Full documentation
```

## Common Commands

| Command | Description |
|---------|-------------|
| `./dev.sh` | Start development environment |
| `./build.sh` | Build for production |
| `databricks bundle deploy --target dev` | Deploy to Databricks dev |
| `databricks bundle deploy --target prod` | Deploy to Databricks prod |
| `python src/my_project/main.py` | Run backend only |
| `cd frontend && npm start` | Run frontend only |

## Need Help?

- 📖 Full documentation: See [README.md](README.md)
- 🚀 Deployment guide: See [DEPLOYMENT.md](DEPLOYMENT.md)
- 💻 FastAPI docs: https://fastapi.tiangolo.com/
- ⚛️ React docs: https://react.dev/
- 🧱 Databricks Bundles: https://docs.databricks.com/dev-tools/bundles/

Happy coding! 🎉

