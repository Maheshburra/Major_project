# Use Python slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Django port
EXPOSE 8000

# Run Gunicorn server
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "mysite_django_project.wsgi:application"]
