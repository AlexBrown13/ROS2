FROM osrf/ros:humble-desktop
 
ENV ROS_DISTRO=humble
ARG USERNAME=ros-humble-desktop
ARG USER_UID=1000
ARG USER_GID=$USER_UID
 
# Extra build/dev tools not included in the base image
RUN apt-get update && apt-get install -y \
    python3-argcomplete \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    build-essential \
    sudo \
    git \
    nano \
    vim \
    gazebo \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros2-control \
    && rm -rf /var/lib/apt/lists/*
 
# Create non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
 
# Source ROS setup on every shell
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc \
    && echo 'if [ -f ~/ros2_ws/install/setup.bash ]; then source ~/ros2_ws/install/setup.bash; fi' >> /home/${USERNAME}/.bashrc
 
# Create workspace and VS Code server directory for ros-humble-image
# RUN mkdir -p /home/$USERNAME/ros2_ws/src \
#     && chown -R $USERNAME:$USERNAME /home/$USERNAME/ros2_ws


# Create workspace and VS Code server directory for ros-humble-image_1
RUN mkdir -p /home/$USERNAME/ros2_ws/src \
    && mkdir -p /home/$USERNAME/.vscode-server \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME

# Set workspace
WORKDIR /home/$USERNAME/ros2_ws

# Switch to normal user
USER $USERNAME

# Start shell
CMD ["bash"]
 