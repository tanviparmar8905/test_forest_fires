FROM python:3.9-slim

# Create a non-root user for better security
RUN useradd -m -u 1000 user

# Set working directory
WORKDIR /application

# Copy application files and ensure correct permissions
COPY . /application
RUN chmod -R 755 /application

# Switch to non-root user
USER user

# Install dependencies
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Expose the required port
EXPOSE 7860

# Run the Flask application using Gunicorn
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:7860", "application:app"]
