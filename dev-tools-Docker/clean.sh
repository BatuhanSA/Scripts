#!/bin/bash 

CONTAINER_TO_KEEP="DooD-Testing"
IMAGE_TO_KEEP="test"

# Function to display help
show_help() {
  echo "Usage: demo.sh [-a]"
  echo "  -a    Delet all Docker files"
}

# Initialize flags
flag_a=false

# Parse options
while getopts "ah" opt; do
  case ${opt} in
    a)
      flag_a=true
      ;;
    h)
      show_help
      exit 0
      ;;
    \?)
      show_help
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))


# Get all container IDs
container_ids=$(docker ps -aq)
keep_container_id=$(docker ps -aq -f "name=$CONTAINER_TO_KEEP")

# Get all image IDs
image_ids=$(docker images -aq)
keep_image_id=$(docker images -aq "$IMAGE_TO_KEEP")


# Delets all the containers and images
if ($flag_a); then
  containers_to_delete=$(echo "$container_ids")
  images_to_delete=$(echo "$image_ids")
fi

# Delets all the containers and images except for the testing ones
if ! $flag_a; then
  echo "No flags set. Performing default action..."
  # Remove all containers except the one you want to keep
  containers_to_delete=$(echo "$container_ids" | grep -v $keep_container_id)
  images_to_delete=$(echo "$image_ids" | grep -v "$keep_image_id")
  # Add your default action code here
fi

if [ -n "$containers_to_delete" ]; then
  echo "Deleting all containers except $CONTAINER_TO_KEEP..."
  docker rm -f $containers_to_delete
  echo "Containers have been deleted."
else
  echo "No containers to delete."
fi

if [ -n "$images_to_delete" ]; then
    echo "Deleting all images except $IMAGE_TO_KEEP..."
    docker rmi -f $images_to_delete
    echo "Images have been deleted."
else
    echo "No images to delete."
fi




