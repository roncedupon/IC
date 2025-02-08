# %%
import sys
from PyQt5.QtWidgets import QApplication, QLabel, QMainWindow

# 定义主窗口类
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        # 设置窗口标题
        self.setWindowTitle("我的第一个 PyQt5 程序")

        # 创建一个标签
        label = QLabel("欢迎使用 PyQt5！", self)

        # 设置标签的大小和位置
        label.setGeometry(50, 50, 200, 50)

        # 设置窗口大小
        self.setGeometry(100, 100, 400, 300)

# 主程序入口
if __name__ == "__main__":
    app = QApplication(sys.argv)  # 创建应用程序实例
    window = MainWindow()         # 创建主窗口
    window.show()                 # 显示窗口
    sys.exit(app.exec())          # 进入主事件循环
