# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for caching
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/

# Collect static files (optional)
RUN python manage.py collectstatic --noinput || echo "No static files to collect"

# Gunicorn entry point (update wsgi path)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "mysite_django_project.wsgi:application"]


