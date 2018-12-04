//
//  Global.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/27.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

// import AMapFoundationKit

// 捕捉时限
let MAXCatchTime: Float = 20.0
// 捕获所需点击数
let MAXTapNum = 50
// 离镜头最近距离
let MINDistanceFromCamera: Float = 1.0
// 离镜头最远距离
let MAXDistanceFromCamera: Float = 3.0

// 当前萌娘类型数
var girlIdNow: Int = 1
// 是否开始搜索萌娘
var startToSearch: Bool = false
// 是否搜索到萌娘
var finishSearch: Bool = false
// 是否完成捕捉
var finishCatch: Bool = false
// 当前所剩捕捉时间
var countDownTime: Float = MAXCatchTime
// 当前点击数
var tapNum: Int = 0

// 用户当前位置
var myLocation: CLLocation? = CLLocation(latitude: 0, longitude: 0)
// 用户附近多少米可发现萌娘
let nearRange: Double = 1000.0
// 用户附近多少米可捕捉萌娘
let catchRange: Double = 20.0

// 地图上所有萌娘标注
var girlAnnotations: [Int: MoeGirlAnnotation] = [Int: MoeGirlAnnotation]()

// AR界面的捕捉相关数值初始化
func initGlobalInCameraView() {
    startToSearch = false
    finishSearch = false
    finishCatch = false
    countDownTime = MAXCatchTime
    tapNum = 0
}

// 随机整数
func randomInt(min: Int, max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}

// 随机浮点数
func randomFloat(min: Float, max: Float) -> Float {
    return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}
func randomDouble(min: Double, max: Double) -> Double {
    return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}
