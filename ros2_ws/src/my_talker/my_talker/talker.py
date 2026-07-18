import rclpy
from rclpy.node import Node

from std_msgs.msg import String


class Talker(Node):

    def __init__(self):
        super().__init__('my_talker')

        self.publisher = self.create_publisher(
            String,
            'chatter',
            10
        )

        self.counter = 0

        self.timer = self.create_timer(
            1,
            self.publish_message
        )

    def publish_message(self):
        msg = String()

        msg.data = f'Hello ROS2: {self.counter}'

        self.publisher.publish(msg)

        self.get_logger().info(
            f'Publishing: "{msg.data}"'
        )

        self.counter += 1


def main(args=None):
    rclpy.init(args=args)
    node = Talker()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()