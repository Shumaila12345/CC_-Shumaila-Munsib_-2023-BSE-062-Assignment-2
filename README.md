# Assignment 2 – Multi-Tier Web Infrastructure using Terraform & Nginx

## Project Overview
This project implements a multi-tier web infrastructure on AWS using Terraform.
The architecture consists of an Nginx reverse proxy acting as a load balancer
in front of multiple backend web servers. The infrastructure supports HTTPS,
caching, security groups, and modular Terraform design.

The goal of this assignment is to demonstrate Infrastructure as Code (IaC),
load balancing, reverse proxy configuration, and proper deployment practices.

---

## Architecture Overview

┌─────────────────────────────────────────────────┐
│ Internet │
└─────────────────┬───────────────────────────────┘
│
│ HTTPS (443) / HTTP (80)
▼
┌────────────────────┐
│ Nginx Server │
│ (Load Balancer) │
│ - SSL/TLS │
│ - Reverse Proxy │
│ - Caching │
└────────┬───────────┘
│
┌───────────┼───────────┐
│ │ │
▼ ▼ ▼
┌─────┐ ┌─────┐ ┌─────┐
│Web-1│ │Web-2│ │Web-3│
│ │ │ │ │(BKP)│
└─────┘ └─────┘ └─────┘
Primary Primary Backup

---

## Components Description

### 1. Nginx Load Balancer
- Acts as a reverse proxy
- Handles HTTPS termination
- Forwards traffic to backend servers
- Provides caching and security headers

### 2. Backend Web Servers
- Apache web servers
- Serve different web pages (web1, web2, web3)
- Placed behind the Nginx proxy

### 3. Networking
- Custom VPC
- Public subnet
- Internet Gateway
- Route tables

### 4. Security Groups
- Nginx Security Group:
  - Allow HTTP (80)
  - Allow HTTPS (443)
  - Allow SSH (22)
- Backend Security Group:
  - Allow HTTP from Nginx only
  - Allow SSH for management

---

## Prerequisites

### Required Tools
- Terraform (v1.x or later)
- AWS CLI
- Git
- SSH client (PowerShell / Git Bash)

### AWS Credentials Setup
AWS credentials must be configured using:

### SSH Key Setup
- SSH key pair generated locally
- Public key provided to Terraform
- Private key used for SSH access

---

## Deployment Instructions

### Step-by-Step Guide

1. Clone or copy the project folder
2. Navigate to project directory:

3. Initialize Terraform:

4. Configure variables in `terraform.tfvars`

5. Validate configuration:

6. Deploy infrastructure:

7. Type `yes` when prompted

---

## Variable Configuration

- `region`: AWS region
- `instance_type`: EC2 instance type
- `public_key`: Path to SSH public key
- `vpc_cidr_block`: CIDR for VPC
- `subnet_cidr_block`: CIDR for subnet

---

## Configuration Guide

### Updating Backend IPs
Backend IPs are automatically managed using Terraform outputs.
To add or remove backend servers, update the backend server list
inside `locals.tf`.

### Nginx Configuration Explanation
- `upstream backend_servers`: Defines backend pool
- `proxy_pass`: Forwards requests to backend servers
- `error_page`: Custom error handling
- `ssl_certificate`: Enables HTTPS

### Testing Procedures
- Access Nginx public IP in browser
- Refresh page to observe load balancing
- Stop backend servers to test error pages
- Access invalid URL to test 404 error

---

## Architecture Details

### Network Topology
- Single VPC
- One public subnet
- All instances connected via security groups

### Security Groups Explanation
- Nginx SG allows internet traffic
- Backend SG restricts access to Nginx only

### Load Balancing Strategy
- Round-robin load balancing
- Automatic failover to backup server

---

## Troubleshooting

### Common Issues and Solutions
- SSH permission denied → Check key path
- Nginx not loading → Restart nginx service
- Plain text error pages → Check `error_page` configuration

### Log Locations
- Nginx Access Log:
- Nginx Error Log:

### Debug Commands

---

## Author
Assignment completed as part of Cloud Computing / DevOps Lab.
