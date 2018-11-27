# MoeGirls-Go
- 这是一个类似 Pokemon Go 的基于地图的AR游戏

- 模块：

  - [高德地图SDK](https://lbs.amap.com/api/ios-sdk/summary)（代替 MapKit）

  - [ARKit](https://developer.apple.com/documentation/arkit) + [SpriteKit](https://developer.apple.com/documentation/spritekit)（实现 2D 增强现实和交互）
  - [CloudKit](https://developer.apple.com/documentation/cloudkit)（云端存储/恢复）
  - [GameKit](https://developer.apple.com/documentation/gamekit)（Game Center 登录）

- 界面关系：
  - 主界面：所有功能的入口
    - 跳转到“地图界面”
    - 跳转到“图鉴界面”
    - 云端存储按钮
    - 云端恢复按钮
  - 地图界面：发现地图上的萌娘出现位置
    - 跳转到“AR 界面”
    - 返回主界面
  - AR 界面：调用摄像头显示并结交萌娘
    - 返回“地图界面”
    - 交互（快速在倒计时结束前点击一定次数以“结交”萌娘）
    - 弹出“结交成功/失败界面”
  - 图鉴界面：查看已结交的萌娘
  - 其他界面或功能待定

- 版本说明及展望：

  - version 0.x：极简版（12.4提交版）

    完成全部流程，但是萌娘的位置等属性是“事先预定好的”，没有复杂的判断；没有精美的界面

  - version 1.x：完善版

    完善功能，能够供人娱乐

  - version 2.x：精致版（1.11最终版）

    完善界面，交互和动画

  - version 3.x ～ ...







