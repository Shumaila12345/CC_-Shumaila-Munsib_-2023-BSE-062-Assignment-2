output "nginx_public_ip" {
  description = "Public IP of Nginx server"
  value       = module.nginx_server.public_ip
}


output "backend_servers_info" {
  description = "Backend servers information"
  value = {
    for name, server in module.backend_servers : name => {
      instance_id = server.instance_id
      public_ip   = server.public_ip
      private_ip  = server.private_ip
    }
  }
}