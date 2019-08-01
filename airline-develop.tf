# Create memorystore instance for redis
module "memorystore-instance" {
  source             = "./redis"
  redis_name         = "official-website-dev-redis"
  redis_tier         = "STANDARD_HA"
  redis_region       = "asia-east1"
  redis_zone         = "asia-east1-a"
  redis_alt_zone     = "asia-east1-b"
  redis_memory_size  = "8"
  redis_auth_network = var.develop-network-sharedvpc
  redis_version      = "REDIS_4_0"
}
