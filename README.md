# MoeGirls-Go
- 这是一个类似 Pokemon Go 的基于地图的AR游戏



### 配置说明

请参照 GitHub 上的 wiki 文档



### 功能与界面说明

- 模块：

  - [高德地图SDK](https://lbs.amap.com/api/ios-sdk/summary)（代替 MapKit）
  - [ARKit](https://developer.apple.com/documentation/arkit) + [SpriteKit](https://developer.apple.com/documentation/spritekit)（实现 2D 增强现实和交互）
  - [CoreData](https://developer.apple.com/documentation/coredata)（数据的持久化存储）
- 界面关系：
  - 开始界面：选择角色/玩家
    - 点击“选择角色”，跳出一个表单来选择角色以存档（共有5个位置可供存档），各个存档之间互不干涉；可以创建新角色或选择已有的角色
    - 点击“进入世界”，跳转到所选存档的【主界面】
  - 主界面：大部分功能的入口
    - 点击左侧的“靶子”，跳转到【地图界面】
    - 点击上方的“图鉴”，跳转到【图鉴界面】
    - 点击左上角的用户头像，跳转到【角色界面】
  - 地图界面：发现地图上的萌娘出现位置
    - 点击左上角的“返回图标”，回到【主界面】
    - 点击左侧的“刷新图标”，刷新地图上的图钉
    - 当萌娘位置距离自己在15m之内时，可以点开该图钉，再点击“i”按钮，跳转到【AR 界面】
  - AR 界面：调用摄像头显示并结交萌娘
    - 点击左上角的“返回图标”，返回【地图界面】
    - 交互，先点击“开始搜索按钮”，再随意点一下屏幕，就会在自己周围360度球形范围内生成一个萌娘，开始倒计时，快速在倒计时结束前点击50次（次数显示在屏幕右上角）就能成功“结交”萌娘，若规定时间不能做到则失败
    - 弹出【结交成功/失败界面】，成功界面则是萌娘图鉴的节选，可以返回【地图界面】；失败则直接返回【地图界面】，此时刚刚点击的图钉已经消失了
  - 图鉴界面：查看已结交的萌娘
    - 点击左上角的“返回图标”，返回【主界面】
    - 上方的控件可以分类查看萌娘
    - 左侧的4个按钮可以以4种排列方式排序图鉴，包括以编号、战斗力、稀有度、亲密度来排序
    - 点击某个“卡片”，进入【详细信息界面】
  - 详细信息界面：查看某一个萌娘的详细信息
    - 点击左上角的“返回图标”，返回【图鉴界面】
  - 角色界面：查看当前角色存档的游戏进度信息；更改头像；切换角色
    - 左侧的文字表述的当前的游戏进度（即“成就”）
    - 右侧为当前头像，点击则进入【头像选择界面】
    - 点击右下的“切换角色”按钮，可以回到【开始界面】重新选择角色或创建新角色
  - 头像选择界面：改变当前所使用的头像
    - 在7种头像中选择一个，点击后，再点击右下的“返回图标”返回【角色界面】，则当前头像已经更改







