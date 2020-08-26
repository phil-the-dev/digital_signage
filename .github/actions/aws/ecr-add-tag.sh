#!/bin/sh

###
# An AWS CLI script to add a tag to an ECR image
# Inputs:
#   $1 -> the existing tag of an existing image
#   $@ -> the tag(s) to be added to the existing image
###

SEEK=$1
shift
MANIFEST=$( aws ecr batch-get-image --repository-name lm-base-nodejs --image-ids imageTag=${SEEK} --query 'images[].imageManifest' --output text --region us-west-2 )

for tag in "$@"; do
    aws ecr put-image --repository-name lm-base-nodejs --image-tag ${tag} --image-manifest "$MANIFEST" --region us-west-2
done 