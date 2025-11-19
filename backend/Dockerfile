# Use an official Python runtime as a parent image
FROM python:3.11-slim
RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*
# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install  -r requirements.txt


EXPOSE 5000


CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0" ]