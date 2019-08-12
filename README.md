# airline-develop
## Deploy
1. Enable API: Memorystore for Redis API, Service Networking API<br />
2. Create a redis and replica<br />

## Command Line
1. List the redis instances<br />
gcloud redis instances list --region=asia-east1<br />
2. Describe the redis instance<br />
gcloud redis instances describe official-website-dev-redis --region=asia-east1<br />
3. Build and push the container image to Container Registry:<br />
cp gke_deployment/Dockerfile .<br />
export PROJECT_ID="$(gcloud config get-value project -q)"<br />
docker build -t gcr.io/${PROJECT_ID}/visit-counter:v1 .<br />
gcloud docker -- push gcr.io/${PROJECT_ID}/visit-counter:v1<br />
4. gcloud container images list - list existing images<br />
gcloud container images list<br />
5. To avoid hard-coding the Redis instance IP, you can create a redishost ConfigMap<br />
export REDISHOST_IP=XXX.XXX.XXX.XXX<br />
kubectl create configmap redishost --from-literal=REDISHOST=${REDISHOST_IP}<br />
6. Verify the configuration using the following command<br />
kubectl get configmaps redishost -o yaml<br />
7. Apply the .yaml configuration to your cluster<br />
kubectl apply -f gke_deployment/visit-counter.yaml<br />
8. Determine the [EXTERNAL-IP] address for this sample app<br />
kubectl get service visit-counter<br />
9. Get the pods<be />
kubectl get pods<br />
10. Delete the .yaml configuration to your cluster<br />
kubectl delete -f gke_deployment/visit-counter.yaml<br />
11. List container images on Container Registry<br />
gcloud container images list<br />
12. Delete a images from Container Registry<br />
gcloud container images delete gcr.io/official-website-dev/visit-counter:v1<br />

## Reference Link
1. Cloud SDK - gcloud reference - overview<br />
https://cloud.google.com/sdk/gcloud/reference/<br />
2. Creating and managing Redis instances<br />
https://cloud.google.com/memorystore/docs/redis/creating-managing-instances<br />
3. Memorystore for Redis - Networking - Limited and unsupported networks<br />
https://cloud.google.com/memorystore/docs/redis/networking#limited_and_unsupported_networks<br />
4. Memorustore for Redis - Quickstart using the gcloud command-line tool<br />
https://cloud.google.com/memorystore/docs/redis/quickstart-gcloud<br />
5. Memorystore for Redis - Connecting to a Redis instance from a Compute Engine VM<br /> 
https://cloud.google.com/memorystore/docs/redis/connecting-redis-instance#connecting-compute-engine<br />
6. Memorystore for Redis - Connecting to a Redis instance from a Google Kubernetes Engine pod<br />
https://cloud.google.com/memorystore/docs/redis/connecting-redis-instance#connecting-pod<br />
7. Memorystore for Redis - From a Kubernetes Engine cluster - Sample appication<br />
https://cloud.google.com/memorystore/docs/redis/connect-redis-instance-gke#sample_application<br />
