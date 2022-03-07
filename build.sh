docker buildx use mybuilder
docker buildx build --no-cache --platform linux/amd64,linux/arm64 -t brianlmerritt/neato_ros_foxy:latest --push .