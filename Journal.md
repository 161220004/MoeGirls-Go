# 开发日志

### 2018.11.20

实现原生地图的定位追踪功能

### 2018.11.21

改用高德地图SDK以获得更加个性化的展示

例如：自定义当前位置小蓝点，自定义动画等等

参考：https://lbs.amap.com/api/ios-sdk/gettingstarted

然而失败了（linker command failed with exit code 1 (use -v to see invocation)），初步怀疑与版本问题有关

### 2018.11.22

采用AVFoundation获取摄像头视图，然而显示不出来

### 2018.11.23

采用ARKit获取摄像头

### 2018.11.24/25

基本实现AR（最简版）；解决了“Thread 1: signal SIGABRT”的奇怪bug（clean project万能）

### 2018.11.26/27

实现对于一个“固定点萌娘”的发现和AR捕获的全过程

