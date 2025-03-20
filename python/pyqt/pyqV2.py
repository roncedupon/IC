import sys
from PyQt5.QtWidgets import QApplication, QLabel, QPushButton, QVBoxLayout, QWidget

class CounterApp(QWidget):
    def __init__(self):
        super().__init__()

        # 初始化计数器
        self.counter = 0

        # 设置窗口标题
        self.setWindowTitle("点击加一")

        # 创建布局
        layout = QVBoxLayout()

        # 创建标签，用于显示计数值
        self.label = QLabel(f"当前计数：{self.counter}")
        layout.addWidget(self.label)

        # 创建按钮
        self.button = QPushButton("点击加一")
        layout.addWidget(self.button)

        # 绑定按钮点击事件
        self.button.clicked.connect(self.increment_counter)

        # 设置窗口布局
        self.setLayout(layout)

    def increment_counter(self):
        """按钮点击事件，计数加一并更新显示。"""
        self.counter += 1
        self.label.setText(f"当前计数：{self.counter}")

# 主程序入口
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = CounterApp()
    window.show()
    sys.exit(app.exec())
