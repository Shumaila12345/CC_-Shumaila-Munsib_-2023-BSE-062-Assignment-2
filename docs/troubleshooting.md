# 🛠 Troubleshooting Guide - Assignment 2

This document outlines common issues encountered during the deployment of the multi-tier infrastructure and how to resolve them.

## 1. Terraform Issues
### Error: "Resource already exists"
* **Cause:** A manual change was made in the AWS console or a previous `apply` failed halfway.
* **Fix:** Run `terraform import` for the resource or manually delete it from the AWS console and run `terraform apply` again.

### Error: "Requesting a public IP is not supported for the given instance type"
* **Fix:** Ensure you are using a supported instance type like `t3.micro` or `t2.micro` in your `terraform.tfvars`.

## 2. Nginx Connectivity Issues
### 502 Bad Gateway
* **Cause:** Nginx cannot reach the Apache backend servers.
* **Fix:** 1. Check if Apache is running on the backend: `sudo systemctl status httpd`.
    2. Verify the Private IPs in `/etc/nginx/nginx.conf` match the actual backend IPs.
    3. Ensure the Security Group allows Port 80 traffic from the Nginx SG to the Backend SG.

### SSL/TLS Warning
* **Cause:** Using a self-signed certificate.
* **Fix:** This is expected for this assignment. Click "Advanced" and "Proceed to [IP]" in your browser.

## 3. Script Execution Issues
### Apache or Nginx not starting
* **Fix:** Check user-data logs on the EC2 instance:
    ```bash
    sudo cat /var/log/cloud-init-output.log
    ```

## 4. Useful Debug Commands
* **Test Nginx Config:** `sudo nginx -t`
* **Check Nginx Logs:** `sudo tail -f /var/log/nginx/error.log`
* **Check Apache Logs:** `sudo tail -f /var/log/httpd/error_log`