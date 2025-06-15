# --- Stage 1: Base Image ---
# We start from an official, lightweight Python image. This is our clean OS.
FROM python:3.11-slim

# --- Stage 2: Set up the Environment ---
# Set the working directory inside the container. All subsequent commands run here.
WORKDIR /app

# --- Stage 3: Copy Files and Install Dependencies ---
# Copy the requirements file first. This is a Docker best practice that uses caching.
# If this file doesn't change, Docker won't re-install the packages on future builds, making them much faster.
COPY requirements.txt .

# Use pip to install the Python packages specified in the requirements file.
RUN pip install --no-cache-dir -r requirements.txt

# Now that dependencies are installed, copy the rest of our application files into the container.
COPY . .

# --- Stage 4: Expose Port and Define Run Command ---
# Tell Docker that the application inside the container will listen on port 8501.
EXPOSE 8501

# This is the command that will be executed when the container starts.
# It's the same command we used to run the app locally.
CMD ["streamlit", "run", "dashboard_app/app.py"]