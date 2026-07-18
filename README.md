# ROS2 Quick Reference: Nodes, Talker Demo & Turtlesim

A quick-start guide for running ROS2 demo nodes and the Turtlesim simulator.

## Table of Contents
- [Nodes: Talker/Listener Demo](#nodes-talkerlistener-demo)
- [Turtlesim Setup](#turtlesim-setup)
- [Controlling the Turtle](#controlling-the-turtle)
- [Useful Commands](#useful-commands)
- [Docker / X11 Notes](#docker--x11-notes)

---

## Nodes: Talker/Listener Demo

Before running any ROS2 command, make sure your environment is sourced:

```bash
source /opt/ros/humble/setup.bash
```

### Run the Python talker

Runs an example publisher node included with the ROS2 installation.

```bash
ros2 run demo_nodes_py talker
```

**Expected output:**
```
[INFO] [talker]: Publishing: 'Hello World: 0'
[INFO] [talker]: Publishing: 'Hello World: 1'
[INFO] [talker]: Publishing: 'Hello World: 2'
...
```

### Run the listener (optional, in a second terminal)

Subscribes to the talker's messages so you can see the pub/sub relationship in action.

```bash
ros2 run demo_nodes_py listener
```

**Expected output:**
```
[INFO] [listener]: I heard: [Hello World: 0]
[INFO] [listener]: I heard: [Hello World: 1]
...
```

---

## Turtlesim Setup

### Step 1: Install ROS 2 Humble (use in Dockerfile)

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install ros-humble-desktop
```

> **Note:** `ros-humble-desktop` includes GUI tools and is quite large. If you're building
> a lean Docker image and don't need the full desktop suite, consider
> `ros-humble-ros-base` plus the specific packages you need instead.

### Step 2: Install Turtlesim

```bash
sudo apt install ros-humble-turtlesim
```

Check if it's installed:

```bash
ros2 pkg list | grep turtlesim
```

### Step 3: Run Turtlesim

```bash
ros2 run turtlesim turtlesim_node
```

A blue window will appear with a turtle in the center.

> **macOS / Windows users:** You'll need an X11 server (e.g. XQuartz) to display the
> turtle window. See [Docker / X11 Notes](#docker--x11-notes) below for details.

---

## Controlling the Turtle

Open a **second terminal** and run:

```bash
ros2 run turtlesim turtle_teleop_key
```

Use the arrow keys to drive the turtle around. Moving the turtle leaves a trail on screen.

---

## Useful Commands

**List all active topics:**
```bash
ros2 topic list
```

**Echo live turtle pose data:**
```bash
ros2 topic echo /turtle1/pose
```

**Clear the screen (trail only — turtle stays in place):**
```bash
ros2 service call /clear std_srvs/srv/Empty
```

---

## Docker / X11 Notes

Turtlesim requires a display to render its GUI window. If you're running ROS2 inside
Docker, you need to forward X11 from the container to your host in addition to
installing an X server on the host machine.

**Linux host:**
```bash
xhost +local:docker
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ...
```

**macOS (via XQuartz):**
1. Install and launch XQuartz.
2. Enable "Allow connections from network clients" in XQuartz preferences.
3. Run `xhost + <your-host-IP>`.
4. Set `DISPLAY` to your host's IP (not `:0`), since Docker Desktop on Mac runs in a VM:
   ```bash
   docker run -e DISPLAY=<your-host-IP>:0 ...
   ```

**Windows:**
XQuartz doesn't apply here — use an X server like [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
or [X410](https://x410.dev/), plus proper WSL2 networking configuration if running
ROS2 under WSL2.

---

## Summary Table

| Command | Description |
|---|---|
| `ros2 run demo_nodes_py talker` | Run example publisher node |
| `ros2 run demo_nodes_py listener` | Run example subscriber node |
| `ros2 run turtlesim turtlesim_node` | Launch Turtlesim simulator |
| `ros2 run turtlesim turtle_teleop_key` | Control turtle with arrow keys |
| `ros2 topic list` | List all active topics |
| `ros2 topic echo /turtle1/pose` | Stream turtle position data |
| `ros2 service call /clear std_srvs/srv/Empty` | Clear turtle's trail |
| `ros2 pkg list \| grep turtlesim` | Verify turtlesim is installed |