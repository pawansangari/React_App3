# Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Databricks Workspace                      │
│                                                               │
│  ┌────────────────────────────────────────────────────────┐  │
│  │              Databricks App (hello_world_app)          │  │
│  │                                                         │  │
│  │  ┌──────────────────┐      ┌──────────────────────┐   │  │
│  │  │                  │      │                       │   │  │
│  │  │  FastAPI Backend │◄────►│   React Frontend      │   │  │
│  │  │   (Port 8080)    │      │   (Static Files)      │   │  │
│  │  │                  │      │                       │   │  │
│  │  └──────────────────┘      └──────────────────────┘   │  │
│  │          │                            │                │  │
│  │          │                            │                │  │
│  │          ▼                            ▼                │  │
│  │    API Endpoints              UI Components           │  │
│  │    - /api/health              - Hello World Card      │  │
│  │    - /api/hello               - Greeting Form         │  │
│  │    - /api/greet/{name}        - Beautiful UI          │  │
│  │                                                         │  │
│  └────────────────────────────────────────────────────────┘  │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Local Development Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Your Computer                            │
│                                                               │
│  ┌──────────────────┐                  ┌──────────────────┐ │
│  │                  │                  │                  │ │
│  │  FastAPI Backend │                  │ React Dev Server │ │
│  │  localhost:8000  │◄────Proxy API────│ localhost:3000   │ │
│  │                  │     Requests     │                  │ │
│  └──────────────────┘                  └──────────────────┘ │
│         │                                      │             │
│         │                                      │             │
│         ▼                                      ▼             │
│    Your Browser                           Your Browser       │
│    API Testing                           UI Development      │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Components

### Backend (FastAPI)
- **Location**: `src/my_project/main.py`
- **Framework**: FastAPI with uvicorn server
- **Port**: 8000 (dev), 8080 (production)
- **Features**:
  - RESTful API endpoints
  - CORS middleware for cross-origin requests
  - Static file serving for React build
  - Health check endpoint
  - Async/await support

### Frontend (React)
- **Location**: `frontend/src/`
- **Framework**: React 18 with Hooks
- **Port**: 3000 (dev only)
- **Features**:
  - Modern functional components
  - State management with useState/useEffect
  - API integration with fetch
  - Responsive design
  - Beautiful gradient UI

### Deployment (Databricks Asset Bundle)
- **Location**: `databricks.yml`, `resources/my_project.app.yml`
- **Deployment Tool**: Databricks CLI
- **Environments**:
  - **Dev**: Development mode with prefixed resources
  - **Prod**: Production mode with full scheduling

## Data Flow

### API Request Flow
```
User Action in Browser
    │
    ▼
React Component (fetch)
    │
    ▼
HTTP Request to /api/endpoint
    │
    ▼
FastAPI Route Handler
    │
    ▼
Business Logic / Data Processing
    │
    ▼
JSON Response
    │
    ▼
React State Update
    │
    ▼
UI Re-render with New Data
```

### Build & Deploy Flow
```
1. Development
   ├── Edit frontend/src/App.js
   └── Edit src/my_project/main.py

2. Build
   ├── npm run build (creates frontend/build/)
   └── cp frontend/build → src/my_project/frontend/

3. Package
   └── uv build --wheel (creates dist/*.whl)

4. Deploy
   ├── databricks bundle validate
   └── databricks bundle deploy --target [dev|prod]

5. Access
   └── https://workspace/apps/hello_world_app/
```

## Technology Stack

### Backend Stack
| Technology | Purpose |
|-----------|---------|
| Python 3.11+ | Programming language |
| FastAPI | Web framework |
| Uvicorn | ASGI server |
| Pydantic | Data validation |

### Frontend Stack
| Technology | Purpose |
|-----------|---------|
| React 18 | UI framework |
| JavaScript | Programming language |
| CSS3 | Styling |
| Fetch API | HTTP requests |

### DevOps Stack
| Technology | Purpose |
|-----------|---------|
| Databricks Asset Bundles | Deployment |
| UV | Python package management |
| npm | Node.js package management |
| Databricks CLI | Deployment tool |

## File Structure

```
my_project/
│
├── src/my_project/               # Backend source
│   ├── __init__.py
│   └── main.py                  # FastAPI app
│
├── frontend/                     # Frontend source
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── App.js              # Main component
│   │   ├── App.css             # Styles
│   │   ├── index.js            # Entry point
│   │   └── index.css           # Global styles
│   └── package.json
│
├── resources/                    # Databricks configs
│   ├── my_project.app.yml      # App definition
│   ├── my_project.job.yml
│   └── my_project.pipeline.yml
│
├── dist/                        # Build artifacts
│   └── *.whl                   # Python wheel
│
├── databricks.yml              # Bundle config
├── pyproject.toml             # Python deps
├── build.sh                   # Build script
├── dev.sh                     # Dev script
│
└── Documentation
    ├── README.md              # Main docs
    ├── DEPLOYMENT.md          # Deploy guide
    ├── QUICKSTART.md          # Quick start
    └── ARCHITECTURE.md        # This file
```

## API Endpoints

| Endpoint | Method | Description | Request | Response |
|----------|--------|-------------|---------|----------|
| `/` | GET | Root endpoint | None | `{"message": "Hello World from FastAPI!"}` |
| `/api/health` | GET | Health check | None | `{"status": "healthy", "message": "..."}` |
| `/api/hello` | GET | Hello world | None | `{"message": "...", "description": "...", "version": "..."}` |
| `/api/greet/{name}` | GET | Personalized greeting | `name: string` | `{"message": "Hello, {name}!"}` |

## Security Considerations

### Current Implementation (Development)
- CORS: Open to all origins (`allow_origins=["*"]`)
- No authentication required
- No rate limiting

### Production Recommendations
1. **CORS**: Restrict to specific domains
2. **Authentication**: Add OAuth2 or API keys
3. **HTTPS**: Enable SSL/TLS
4. **Rate Limiting**: Add request throttling
5. **Input Validation**: Validate all user inputs
6. **Secrets Management**: Use Databricks Secrets

## Scalability

### Current Capacity
- Single instance deployment
- Suitable for demos and small applications

### Future Enhancements
1. **Horizontal Scaling**: Add load balancing
2. **Database**: Add persistent storage (Unity Catalog)
3. **Caching**: Add Redis for API responses
4. **CDN**: Serve static files from CDN
5. **Monitoring**: Add observability (logs, metrics, traces)

## Extension Points

### Backend Extensions
```python
# Add new endpoint in main.py
@app.get("/api/data")
async def get_data():
    # Connect to Databricks tables
    # Process with Spark
    # Return results
    pass
```

### Frontend Extensions
```javascript
// Add new component in App.js
function DataVisualization() {
    // Fetch data from API
    // Display charts/tables
    // Interactive UI
}
```

### Databricks Integration
- Unity Catalog for data access
- Spark for data processing
- MLflow for model serving
- Delta Lake for storage

## Performance Characteristics

| Metric | Development | Production |
|--------|-------------|------------|
| Backend Startup | ~2 seconds | ~5 seconds |
| Frontend Build | ~30 seconds | ~30 seconds |
| API Response Time | <50ms | <100ms |
| Page Load Time | <1 second | <2 seconds |

## Monitoring & Debugging

### Local Development
- **Backend**: Console logs from uvicorn
- **Frontend**: React DevTools, Browser console
- **Network**: Browser DevTools Network tab

### Production
- **Databricks**: App logs in workspace
- **API**: FastAPI automatic documentation at `/docs`
- **Errors**: Databricks error tracking

## Best Practices

1. **Development**: Use hot reload for fast iteration
2. **Testing**: Test API endpoints independently
3. **Building**: Always build frontend before deploying
4. **Deployment**: Validate bundle before deploying
5. **Versioning**: Update version numbers in pyproject.toml

## References

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [React Documentation](https://react.dev/)
- [Databricks Asset Bundles](https://docs.databricks.com/dev-tools/bundles/)
- [Databricks Apps](https://docs.databricks.com/apps/)

