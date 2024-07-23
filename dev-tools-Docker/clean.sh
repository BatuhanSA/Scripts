#!/bin/bash 
# $1 is the Contianer name
# $2
# Replace these with the ID or name of the container and image you want to keep

CONTAINER_TO_KEEP="DooD-Testing"
IMAGE_TO_KEEP="test"

# Get all container IDs
container_ids=$(docker ps -aq)
keep_container_id=$(docker ps -aq -f "name=$CONTAINER_TO_KEEP")
echo "keep id $keep_container_id"

# Get all image IDs
image_ids=$(docker images -aq)
keep_image_id=$(docker images -aq "$IMAGE_TO_KEEP")
echo "keep id $keep_image_id"

# Debugging: print the container IDs and the one to keep
echo "All container IDs: $container_ids"
echo "Container to keep: $CONTAINER_TO_KEEP"

# Remove all containers except the one you want to keep
containers_to_delete=$(echo "$container_ids" | grep -v $keep_container_id)

# Debugging: print the containers to be deleted
echo "Containers to delete: $containers_to_delete"

if [ -n "$containers_to_delete" ]; then
  echo "Deleting all containers except $CONTAINER_TO_KEEP..."
  docker rm -f $containers_to_delete
  echo "Containers have been deleted."
else
  echo "No containers to delete."
fi

# Debugging: print the image IDs and the one to keep
echo "All image IDs: $image_ids"
echo "Image to keep: $IMAGE_TO_KEEP"

# Remove all images except the one you want to keep
images_to_delete=$(echo "$image_ids" | grep -v "$keep_image_id")

# Debugging: print the images to be deleted
echo "Images to delete: $images_to_delete"

if [ -n "$images_to_delete" ]; then
    echo "Deleting all images except $IMAGE_TO_KEEP..."
    docker rmi -f $images_to_delete
    echo "Images have been deleted."
else
    echo "No images to delete."
fi




