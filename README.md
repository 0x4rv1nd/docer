# 📄 DocAI | High-Fidelity PDF Converter

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)

DocAI is a production-ready, minimalist web application for high-fidelity PDF watermark remover. It uses a smart reflow pipeline to ensure your documents look perfect after removing watermarks.

## 🚀 Deployment to Render

This project is optimized for [Render](https://render.com).

### Option 1: One-Click Deploy (Recommended)
1. Push this code to a GitHub repository.
2. Log in to Render.
3. Click **New +** > **Blueprint**.
4. Connect your repo and Render will automatically detect `render.yaml`.

### Option 2: Manual Web Service
1. **Service Type**: Web Service
2. **Runtime**: `Python 3` OR `Docker` (Dockerfile is included)
3. **Build Command**: `pip install -r requirements.txt && apt-get update && apt-get install -y libreoffice`
4. **Start Command**: `python -m app.main`
5. **Environment Variables**:
   - `STORAGE_PROVIDER`: `local` (default) or `supabase`
   - `PORT`: `8000`

## 🛠️ Local Development

1. **Clone & Install**:
   ```bash
   pip install -r requirements.txt
   ```
2. **Environment**:
   ```bash
   cp .env.example .env
   ```
3. **Run**:
   ```bash
   python -m app.main
   ```

## 🏗️ Architecture

- **Backend**: FastAPI
- **Frontend**: Vanilla JS (0 Dependencies)
- **Engine**: pdf2docx + LibreOffice Headless
- **Storage**: Pluggable (Local / Supabase Storage)

## 🔒 Security

- 100MB Upload Limit
- Auto-cleanup of temp files (24h)
- UUID-based isolation
## 📂 Project Structure

```text
docai/
├── app/                # FastAPI Application
├── nginx/              # Nginx Configuration
│   └── geteverythinggpt.conf
├── landing/            # Static Landing Page
│   ├── index.html
│   └── style.css
├── scripts/            # Deployment Utilities
└── docker-compose.yml
```

## 🌐 Deploying with Nginx (Production)

This project is set up to run behind Nginx on a Linux server (e.g., AWS EC2). The landing page lives at the root domain, and the tool is served at `/docai`.

### 1. Prepare Static Files
Copy the landing page files to `/var/www/geteverythinggpt`:
```bash
sudo mkdir -p /var/www/geteverythinggpt
sudo cp -r landing/* /var/www/geteverythinggpt/
sudo chown -R www-data:www-data /var/www/geteverythinggpt
```

### 2. Configure Nginx
Copy the configuration file to Nginx's sites-available:
```bash
sudo cp nginx/geteverythinggpt.conf /etc/nginx/sites-available/
```

### 3. Enable the Site
Create a symbolic link to enable the configuration and test it:
```bash
sudo ln -s /etc/nginx/sites-available/geteverythinggpt.conf /etc/nginx/sites-enabled/
sudo nginx -t
```

### 4. Restart Nginx
If the test is successful, reload Nginx to apply changes:
```bash
sudo systemctl restart nginx
```

### 5. Running the App
Ensure your Docker container is running on port `8000`:
```bash
docker-compose up -d
```

---
Built with ❤️ for GetEverythingGPT.com
