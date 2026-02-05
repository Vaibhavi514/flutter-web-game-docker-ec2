# 🎮 Flutter Web Game Deployment on AWS EC2 using Docker

This project demonstrates how to build a Flutter web application, containerize it using Docker, and deploy it on an AWS EC2 instance.
The application is a simple interactive game with a clean UI, deployed and served using Nginx inside a Docker container.

# 🚀 Project Overview

Built a Flutter-based web game

Generated production-ready web build using Flutter

Dockerized the web build using Nginx

Deployed and ran the Docker container on AWS EC2

Exposed the application to the internet via EC2 Security Groups

# 🛠️ Tech Stack

Flutter (Web)

Docker

Nginx

AWS EC2 (Ubuntu)

Linux

# 📂 Project Structure
flutter-web-game/
│
├── build/web/        # Flutter web build output
├── Dockerfile        # Docker configuration
├── lib/              # Flutter source code
├── pubspec.yaml
└── README.md

# 🐳 Dockerfile (High-level Explanation)

Uses Nginx as a lightweight web server

Copies Flutter build/web files into Nginx HTML directory

Exposes port 80 for web access

# ⚙️ Steps to Run the Project
1️⃣ Build Flutter Web App (Local or EC2)
flutter build web

2️⃣ Build Docker Image
docker build -t flutter-web-game .

3️⃣ Run Docker Container
docker run -d -p 80:80 --name flutter-game flutter-web-game

4️⃣ Access Application

Open your browser:

http://<EC2_PUBLIC_IP>

# 🔐 AWS Configuration

EC2 Instance: Ubuntu

Inbound Rule:

Port: 80

Protocol: HTTP

Source: 0.0.0.0/0

# 🧠 Key Learnings

Flutter web build process

Docker image creation and container lifecycle

Nginx as a static web server

Cloud deployment using AWS EC2

Networking and port mapping in Docker
