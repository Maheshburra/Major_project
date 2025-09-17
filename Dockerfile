# Use official slim Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies in a single RUN to reduce layers
RUN apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev gcc curl \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy only requirements first for caching
COPY requirements.txt .

# Upgrade pip and install Python dependencies (no cache)
RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Collect static files (safely)
RUN if [ -f manage.py ]; then python manage.py collectstatic --noinput; else echo "No manage.py found"; fi

# Set environment variables for production
ENV PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=mysite.settings

# Expose Django port
EXPOSE 8000

# Use gunicorn as default entrypoint
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3", "--threads", "2"]
