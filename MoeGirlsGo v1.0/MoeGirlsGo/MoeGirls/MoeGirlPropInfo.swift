//
//  MoeGirlPropInfo.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/7.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation

// 某一个萌娘的公式书+图鉴信息
class MoeGirlPropInfo: NSObject {
    
    var girlId: Int = 1
    
    var girlGroupId: Int = 0
    var girlName: String = "-"
    var girlDescription: String = "-"
    var girlDetail: String = "-"
    var girlRareLevel: Int = 0
    var girlFightLevel: Int = 0
    
    var encountered: Bool = false
    var encounterDate: Date = Date(timeIntervalSinceReferenceDate: 0)
    var favorLevel: Int = 0
    var favorExpPercent: Int = 0

    override init() {
        super.init()
    }
    
    // 固定赋值
    func setFix(prop: MoeGirlProperty, info: MoeGirlInformation) {
        if prop.girlId == info.girlId {
            girlId = prop.girlId
            
            girlGroupId = prop.girlGroupId
            girlName = prop.girlName
            girlDescription = prop.girlDescription
            girlDetail = prop.girlDetail
            girlRareLevel = prop.girlRareLevel
            girlFightLevel = prop.girlFightLevel
            
            encountered = info.encountered
            encounterDate = info.encounterDate
            favorLevel = info.favorLevel
            favorExpPercent = info.favorExpPercent
        }
    }
    func setFix(propinfo: MoeGirlPropInfo) {
        girlId = propinfo.girlId
        girlGroupId = propinfo.girlGroupId
        girlName = propinfo.girlName
        girlDescription = propinfo.girlDescription
        girlDetail = propinfo.girlDetail
        girlRareLevel = propinfo.girlRareLevel
        girlFightLevel = propinfo.girlFightLevel
        encountered = propinfo.encountered
        encounterDate = propinfo.encounterDate
        favorLevel = propinfo.favorLevel
        favorExpPercent = propinfo.favorExpPercent
    }
    
    init(prop: MoeGirlProperty, info: MoeGirlInformation) {
        super.init()
        setFix(prop: prop, info: info)
    }
}
