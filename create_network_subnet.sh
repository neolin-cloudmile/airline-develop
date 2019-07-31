#!/bin/bash

#Create a custom mode network
gcloud compute networks create develop-newtork-sharedvpc \
    --subnet-mode=custom \
    --bgp-routing-mode=global

#== official-web-site-dev ==
##Adding subnets - official-website-dev for public-subnet-1
gcloud compute networks subnets create official-website-public-subnet-1 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.130.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - official-website-dev for public-subnet-2
gcloud compute networks subnets create official-website-public-subnet-2 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.132.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - official-website-dev for private-subnet-1
gcloud compute networks subnets create official-website-private-subnet-1 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.134.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - official-website-dev for private-subnet-k8s 
gcloud compute networks subnets create official-website-private-subnet-k8s \
    --network=develop-newtork-sharedvpc \
    --range=10.240.136.0/23 \
    --region=asia-east1 \
    --enable-private-ip-google-access

#== buyshopping-dev ==
##Adding subnets - buyshopping-dev for public-subnet-1
gcloud compute networks subnets create buyshopping-public-subnet-1 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.162.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - buyshopping-dev for public-subnet-2
gcloud compute networks subnets create buyshopping-public-subnet-2 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.164.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - buyshopping-dev for private-subnet-1
gcloud compute networks subnets create buyshopping-private-subnet-1 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.166.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - buyshopping-dev for private-subnet-2
gcloud compute networks subnets create buyshopping-private-subnet-2 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.168.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access

#== starlux-dev ==
##Adding subnets - starlux-dev for public-subnet-1
gcloud compute networks subnets create starlux-public-subnet-1 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.194.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - starlux-dev for public-subnet-2
gcloud compute networks subnets create starlux-public-subnet-2 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.196.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - starlux-dev for private-subnet-1
gcloud compute networks subnets create starlux-private-subnet-1 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.198.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - starlux-dev for private-subnet-2
gcloud compute networks subnets create starlux-private-subnet-2 \
    --network=develop-newtork-sharedvpc \
    --range=10.240.200.0/24 \
    --region=asia-east1 \
    --enable-private-ip-google-access
##Adding subnets - starlux-dev for private-subnet-k8s
gcloud compute networks subnets create starlux-private-subnet-k8s \
    --network=develop-newtork-sharedvpc \
    --range=10.240.202.0/23 \
    --region=asia-east1 \
    --enable-private-ip-google-access
