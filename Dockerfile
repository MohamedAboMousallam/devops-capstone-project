FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application content
COPY service/ ./service/

# Switch to a non-root user
RUN useradd --uid 1000 Mohamed && chown -R Mohamed /app
USER Mohamed

# Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
