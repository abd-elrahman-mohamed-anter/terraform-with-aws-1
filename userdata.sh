#!/bin/bash
sudo apt update -y
sudo apt install -y python3-pip python3-venv -y

sudo python3 -m venv /home/ubuntu/flaskenv
source /home/ubuntu/flaskenv/bin/activate
sudo /home/ubuntu/flaskenv/bin/pip install flask

sudo tee /home/ubuntu/app.py > /dev/null <<EOT
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return """
    <html>
      <head>
        <title>My Flask App</title>
        <style>
          body { 
            font-family: Arial, sans-serif; 
            text-align: center; 
            background-color: #f0f8ff;
            margin-top: 100px;
          }
          h1 {
            color: #2c3e50;
          }
          p {
            color: #16a085;
            font-size: 20px;
          }
        </style>
      </head>
      <body>
        <h1>🚀 Hello from AWS EC2 Flask App with Abdelrahman Mohamed ! </h1>
        <p>Welcome to my first deployed app on the cloud!</p>
      </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
EOT

sudo /home/ubuntu/flaskenv/bin/python /home/ubuntu/app.py
