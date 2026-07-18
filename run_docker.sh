CONTAINER_NAME=ros2-container
IMAGE_NAME=ros-humble-image


docker run --rm -it \
    --net=host --ipc=host \
    --privileged \
    --env="DISPLAY=$DISPLAY" \
    -v "$(pwd)/ros2_ws:/home/ros-humble-desktop/ros2_ws/src" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --name $CONTAINER_NAME \
    $IMAGE_NAME

#/home/ros-humble-desktop/ros2_ws/src
# -v "$(pwd)/ros2_ws:/home/vscode/ros2_ws" \
# -v vscode-extensions:/home/ros-humble-desktop/.vscode-server/extensions \

