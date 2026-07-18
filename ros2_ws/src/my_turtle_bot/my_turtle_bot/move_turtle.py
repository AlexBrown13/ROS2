import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist


class MoveTurtle(Node):
    def __init__(self):
        super().__init__('move_turtle')
        self.publisher_ = self.create_publisher(Twist, '/turtle1/cmd_vel', 10)
        timer_period = 0.5  # seconds
        self.timer = self.create_timer(timer_period, self.timer_callback)

    def timer_callback(self):
        msg = Twist()
        msg.linear.x = 6.0   # move forward
        msg.angular.z = 3.0  # turn (gives a circular path)
        self.publisher_.publish(msg)
        self.get_logger().info(f'Publishing: Turtle linear={msg.linear.x}, angular={msg.angular.z}')


def main(args=None):
    rclpy.init(args=args)
    node = MoveTurtle()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()