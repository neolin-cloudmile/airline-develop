# airline-develop
## Deploy
1. Enable API: Memorystore for Redis API<br />
2. Create a redis and replica<br />

## Command Line
1. List the redis instances<br />
gcloud redis instances list --region=asia-east1<br />
2. Describe the redis instance<br />
gcloud redis instances describe official-website-dev-redis --region=asia-east1<br />

## Reference Link
1. Memorystore for Redis - Networking - Limited and unsupported networks
https://cloud.google.com/memorystore/docs/redis/networking#limited_and_unsupported_networks
2. Memorustore for Redis - Quickstart using the gcloud command-line tool 
https://cloud.google.com/memorystore/docs/redis/quickstart-gcloud
3. Memorystore for Redis - Connecting to a Redis instance from a Compute Engine VM 
https://cloud.google.com/memorystore/docs/redis/connecting-redis-instance#connecting-compute-engine
4. Memorystore for Redis - Connecting to a Redis instance from a Google Kubernetes Engine pod 
https://cloud.google.com/memorystore/docs/redis/connecting-redis-instance#connecting-pod
