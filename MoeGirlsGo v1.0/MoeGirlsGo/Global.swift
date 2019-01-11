
//
//  Global.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/27.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

// import AMapFoundationKit

// 萌娘类型数(从1开始)
let MoeGirlTypeNum: Int = 9

// 萌娘最大亲密度
let MAXFavorLevel: Int = 2

// 所有萌娘公式书
var girlProperties: [Int: MoeGirlProperty] = [Int: MoeGirlProperty]()

// 捕捉时限
let MAXCatchTime: Float = 20.0
// 捕获所需点击数
let MAXTapNum: Int = 50
// 离镜头最近距离
let MINDistanceFromCamera: Float = 0.3
// 离镜头最远距离
let MAXDistanceFromCamera: Float = 0.7

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
var myLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
// 用户附近多少米可发现萌娘
let nearRange: Double = 1000.0
// 用户附近多少米可捕捉萌娘
let catchRange: Double = 20.0

// 地图上萌娘标注最小数量
let MINAnnotationAmount: Int = 20
// 地图上萌娘标注最大数量
let MAXAnnotationAmount: Int = 40
// 地图上所有萌娘标注
var girlAnnotations: [Int: MoeGirlAnnotation] = [Int: MoeGirlAnnotation]()

// 所有萌娘图鉴信息
var girlBook: [Int: MoeGirlInformation] = [Int: MoeGirlInformation]()

// 最多角色数
let MAXPlayerNum: Int = 5
// 当前玩家
var currentPlayer: Player = Player()
// 全部玩家信息
var players: [Player] = [Player]()

// 成就信息：邂逅次数
var totalEncounterNum: Int = 0

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

// 打印所有萌娘信息
func printGirlProperties() {
    for i in 1...MoeGirlTypeNum {
        print("\(i). " + girlProperties[i]!.girlName + " Group\(girlProperties[i]!.girlGroupId)")
    }
}

// 计算某个类别Group的萌娘个数
func getGroupGirlNum(groupId: Int) -> Int {
    var count = 0
    for i in 1...MoeGirlTypeNum {
        if girlProperties[i]!.girlGroupId == groupId {
            count += 1
        }
    }
    return count
}

// 得到某个类别Group的全部萌娘属性+图鉴信息
func getGroupGirls(groupId: Int) -> [MoeGirlPropInfo] {
    var groupGirlPropInfo = [MoeGirlPropInfo]()
    for i in 1...MoeGirlTypeNum {
        if girlProperties[i]?.girlGroupId == groupId {
            groupGirlPropInfo.append(MoeGirlPropInfo(prop: girlProperties[i]!, info: girlBook[i]!))
        }
    }
    return groupGirlPropInfo
}
