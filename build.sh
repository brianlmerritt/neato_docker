docker buildx use mybuilder
docker buildx build --platform linux/amd64 -t brianlmerritt/neato_ros_foxy:latest --push .