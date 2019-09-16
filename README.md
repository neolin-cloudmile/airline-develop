# airline-develop
## Deploy
1. Enable API: Memorystore for Redis API, Service Networking API<br />
2. Create a redis and replica<br />

## Command Line
1. List the redis instances<br />
	```
	gcloud redis instances list --region=asia-east1<br />
	```
2. Describe the redis instance<br />
	```
	gcloud redis instances describe official-website-dev-redis --region=asia-east1<br />
	```
3. Build and push the container image to Container Registry:<br />
	```
	cp gke_deployment/Dockerfile .<br />
	export PROJECT_ID="$(gcloud config get-value project -q)"<br />
	docker build -t gcr.io/${PROJECT_ID}/visit-counter:v1 .<br />
	gcloud docker -- push gcr.io/${PROJECT_ID}/visit-counter:v1<br />
	```
4. gcloud container images list - list existing images<br />
	```
	gcloud container images list<br />
	```
5. To avoid hard-coding the Redis instance IP, you can create a redishost ConfigMap<br />
	```
	export REDISHOST_IP=XXX.XXX.XXX.XXX<br />
	kubectl create configmap redishost --from-literal=REDISHOST=${REDISHOST_IP}<br />
	```
6. Verify the configuration using the following command<br />
	```
	kubectl get configmaps redishost -o yaml<br />
	```
7. Apply the .yaml configuration to your cluster<br />
	```
	kubectl apply -f gke_deployment/visit-counter.yaml<br />
	```
8. Determine the [EXTERNAL-IP] address for this sample app<br />
	```
	kubectl get service visit-counter<br />
	```
9. Get the pods<be />
	```
	kubectl get pods<br />
	```
10. Delete the .yaml configuration to your cluster<br />
	```
	kubectl delete -f gke_deployment/visit-counter.yaml<br />
	```
11. List container images on Container Registry<br />
	```
	gcloud container images list<br />
	```
12. Delete a images from Container Registry<br />
	```
	gcloud container images delete gcr.io/official-website-dev/visit-counter:v1<br />
	```

## Establishing 99.9% Availability for Partner Interconnect

1. Creating the VPC Network
2. Creating Cloud Routers
	```
	gcloud compute routers create router-asia-east1-a --asn 16550 --network develop-newtork-sharedvpc --region asia-east1
	gcloud compute routers create router-asia-east1-b --asn 16550 --network develop-newtork-sharedvpc --region asia-east1
	```
3. Creating VLAN attachments
	```
	gcloud compute interconnects attachments partner create attach-asia-east1-a --router router-asia-east1-a --region asia-east1 --edge-availability-domain availability-domain-1
	```
	```
	Created [https://www.googleapis.com/compute/v1/projects/develop-247613/regions/asia-east1/interconnectAttachments/attach-asia-east1-a].
      Please use the pairing key to provision the attachment with your partner:
      9a2894c9-67ec-417f-bc97-c9623a517051/asia-east1/1
	```
	```
	gcloud compute interconnects attachments partner create attach-asia-east1-b --router router-asia-east1-b --region asia-east1 --edge-availability-domain availability-domain-2
	```
	```
	Created [https://www.googleapis.com/compute/v1/projects/develop-247613/regions/asia-east1/interconnectAttachments/attach-asia-east1-b].
      Please use the pairing key to provision the attachment with your partner:
      eae57156-6fc1-49d1-ada3-c32b5a21c189/asia-east1/2
	```
4. Retrieving pairing keys
	```
	gcloud compute interconnects attachments describe attach-asia-east1-a --region asia-east1
	gcloud compute interconnects attachments describe attach-asia-east1-b --region asia-east1
	```
5. Requesting connections from your service provider
6. Activating VLAN attachments

	a. Describe each VLAN attachment to verify whether your service provider completed configuring them.
	```
	gcloud compute interconnects attachments describe attach-asia-east1-a --region asia-east1 --format '(name,state,partnerMetadata)'
	```
	```
	gcloud compute interconnects attachments describe attach-asia-east1-b --region asia-east1 --format '(name,state,partnerMetadata)'
	```
	b. If the correct service provider has configured your VLAN attachments, activate them by using the -- adminEnabled.
	```
	gcloud compute interconnects attachments partner update attach-asia-east1-a --region asia-east1 --admin-enabled
	```
	```
	gcloud compute interconnects attachments partner update attach-asia-east1-b --region asia-east1 --admin-enabled
	```
7. Configuring Routers
Google automatically adds a BGP peer on each Cloud Router. For layer 2 connections, you must add your on-premises ASN to each BGP peer. For layer 3 connections, you don't need to do anything; Google automatically configures your Cloud Routers with your service provider's ASN.

	a. Describe the Cloud Router that's associated with the attached-asia-east1-a VLAN attachment. In the output, find the name of the automatically created BGP peer that's associated with your VLAN attachment.
	```
	gcloud compute routers describe router-asia-east1-a --region asia-east1
	gcloud compute routers describe router-asia-east1-b --region asia-east1
	```
	b. Update the BGP peer with your on-premises router's ASN.
	```
	gcloud compute routers update-bgp-peer router-asia-east1-a --peer-name auto-ia-bgp-attachment-asia-east1-a-c2c53a710bd6c2e --peer-asn [ON-PREM ASN] --region asia-east1
	```
	```
	gcloud compute routers update-bgp-peer router-asia-east1-b --peer-name auto-ia-bgp-attachment-asia-east1-b-c2c53a710bd6c2e --peer-asn [ON-PREM ASN] --region asia-east1
	```

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
8. Establishing 99.9% Availability for Partner Interconnect <br />
https://cloud.google.com/interconnect/docs/tutorials/partner-creating-999-availability
