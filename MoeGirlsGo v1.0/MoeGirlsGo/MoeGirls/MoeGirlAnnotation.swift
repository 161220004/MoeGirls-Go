//
//  MoeGirlOnMap.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/27.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation

// 地图上的某一个萌娘Annotation标识的属性
// 包括名字(->title)，描述，地图大头针位置，大头针的图片等
class MoeGirlAnnotation: NSObject {
    
    var annoId: Int = 0 // 地图标注Id号，用于数据库
    var girlId: Int = 1 // 萌娘Id号，用于AR
    var girlName: String = "-"
    var girlDescription: String = "-"
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // 固定赋值
    func setFix(aId: Int, gId: Int, name: String, desc: String, location: CLLocationCoordinate2D) {
        annoId = aId
        girlId = gId
        girlName = name
        girlDescription = desc
        coordinate = location
    }
    
    // 随机（用户当前位置的坐标附近nearRange）
    func setRandom() {
        annoId = girlAnnotations.count + 1
        // 萌娘是哪位
        girlId = randomInt(min: 1, max: 9)
        girlName = girlProperties[girlId]!.girlName
        girlDescription = girlProperties[girlId]!.girlDescription
        // 随机生成经纬度
        let xBia = randomDouble(min: -nearRange, max: nearRange) // 随机x偏移
        let yBia = randomDouble(min: -nearRange, max: nearRange) // 随机y偏移
        let myPoint = MAMapPointForCoordinate(myLocation.coordinate) // 当前坐标
        coordinate = MACoordinateForMapPoint(
            MAMapPoint(x: (myPoint.x + xBia).truncatingRemainder(dividingBy: MAMapSizeWorld.width),
                       y: (myPoint.y + yBia).truncatingRemainder(dividingBy: MAMapSizeWorld.height)))
            // 将坐标偏移后换算，注意使用取余防止超出世界范围
    }
}
