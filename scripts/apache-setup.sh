#!/bin/bash
set -e

# Update system
yum update -y

# Install Apache
yum install httpd -y

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Get metadata token (IMDSv2)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Get instance metadata
PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/public-ipv4)
PUBLIC_DNS=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/public-hostname)
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

# Set hostname
hostnamectl set-hostname myapp-webserver

# Create custom HTML page
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Backend Web Server</title>
</head>
<body>
    <h1>Backend Server</h1>
    <p><b>Hostname:</b> $(hostname)</p>
    <p><b>Instance ID:</b> $INSTANCE_ID</p>
    <p><b>Private IP:</b> $PRIVATE_IP</p>
    <p><b>Public IP:</b> $PUBLIC_IP</p>
    <p><b>Public DNS:</b> $PUBLIC_DNS</p>
    <p><b>Deployed:</b> $(date)</p>
    <p><b>Status:</b> Active</p>
</body>
</html>
EOF

chmod 644 /var/www/html/index.html

echo "Apache setup completed successfully!"
