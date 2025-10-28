# Deploy to Databricks - Step by Step

Your app is running locally! Here's how to deploy it to Databricks.

## Prerequisites Check

Make sure you have:
- ✅ Databricks CLI installed
- ✅ Databricks workspace configured

### Check Databricks CLI
```bash
databricks --version
```

If not installed:
```bash
pip install databricks-cli
databricks configure
```

## Deployment Steps

### Step 1: Stop Local Development
Press `Ctrl+C` in the terminal running `dev.sh` to stop the local servers.

### Step 2: Build for Production
```bash
./build.sh
```

**What this does:**
- Builds React frontend → `frontend/build/`
- Copies build → `src/my_project/frontend/`
- Creates Python wheel → `dist/my_project-0.0.1-py3-none-any.whl`

Expected output:
```
🚀 Building Hello World App for Databricks Deployment
==================================================

📦 Step 1: Building React Frontend...
✅ Frontend build complete!

📋 Step 2: Copying frontend build to backend...
✅ Frontend copied to backend!

🐍 Step 3: Building Python wheel...
✅ Python wheel build complete!
```

### Step 3: Validate Databricks Bundle
```bash
databricks bundle validate
```

Expected output:
```
Validation OK!
```

If you see errors, check:
- `databricks.yml` syntax
- Workspace URL is correct
- You're authenticated

### Step 4: Deploy to Development
```bash
databricks bundle deploy --target dev
```

This will:
- Upload your app to Databricks
- Create `[dev your_username] hello_world_app`
- Configure the app resources

Expected output:
```
Uploading bundle files...
Deploying resources...
Deployment complete!
```

### Step 5: Access Your App
After deployment completes, your app will be available at:
```
https://<your-databricks-workspace>/apps/hello_world_app/
```

Or find it in Databricks:
1. Go to your Databricks workspace
2. Click on **Apps** in the left sidebar
3. Look for `[dev your_username] hello_world_app`

## Deploy to Production

When you're ready for production:

```bash
databricks bundle deploy --target prod
```

This creates a production version without the `[dev]` prefix.

## Troubleshooting

### Error: "databricks command not found"
```bash
pip install databricks-cli
databricks configure
```

### Error: "Not authenticated"
```bash
databricks configure
# Enter your workspace URL and token
```

### Error: "Build failed"
```bash
# Make sure you're in the project root
cd /Users/pawanpreet.sangari/React_App3/my_project

# Try building manually
cd frontend
npm run build
cd ..
cp -r frontend/build src/my_project/frontend/
uv build --wheel
```

### Error: "Bundle validation failed"
Check `databricks.yml` and `resources/my_project.app.yml` for syntax errors.

## Manual Build Steps

If `./build.sh` doesn't work:

```bash
# 1. Build frontend
cd frontend
npm run build
cd ..

# 2. Copy to backend
rm -rf src/my_project/frontend
cp -r frontend/build src/my_project/frontend/

# 3. Build Python wheel
uv build --wheel

# 4. Validate
databricks bundle validate

# 5. Deploy
databricks bundle deploy --target dev
```

## Verify Deployment

### Test the API
```bash
# Replace with your actual app URL
curl https://<your-workspace>/apps/hello_world_app/api/health
```

### Test the UI
Open in browser:
```
https://<your-workspace>/apps/hello_world_app/
```

You should see the same beautiful gradient UI you saw locally!

## Quick Reference

| Command | Purpose |
|---------|---------|
| `./build.sh` | Build everything |
| `databricks bundle validate` | Check configuration |
| `databricks bundle deploy --target dev` | Deploy to dev |
| `databricks bundle deploy --target prod` | Deploy to prod |
| `databricks bundle destroy --target dev` | Remove deployment |

## What Gets Deployed

```
Databricks Workspace
└── Apps
    └── [dev username] hello_world_app
        ├── FastAPI backend (port 8080)
        ├── React frontend (static files)
        └── All API endpoints
```

## Next Time

After you make changes:
1. Test locally: `./dev.sh`
2. Build: `./build.sh`
3. Deploy: `databricks bundle deploy --target dev`

## Need Help?

- **Full deployment guide**: See `DEPLOYMENT.md`
- **Databricks docs**: https://docs.databricks.com/dev-tools/bundles/
- **App configuration**: Check `resources/my_project.app.yml`

---

**Ready to deploy?** Run `./build.sh` now! 🚀

