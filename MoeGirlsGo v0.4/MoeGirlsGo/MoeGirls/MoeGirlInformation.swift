//
//  MoeGirlInformation.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/4.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation

// 萌娘图鉴的相关信息，包括是否结识，相遇时间，好感度等
class MoeGirlInformation: NSObject {
    
    var girlId: Int = 1
    var encountered: Bool = false
    var encounterDate: Date = Date(timeIntervalSinceReferenceDate: 0)
    var favorLevel: Int = 0
    var favorExpPercent: Int = 0
    
    init(id: Int) {
        super.init()
        girlId = id
        encountered = false
        encounterDate = Date(timeIntervalSinceReferenceDate: 0)
        favorLevel = 0
        favorExpPercent = 0
    }
    
    // 固定赋值
    func setFix(enc: Bool, encDate: Date, favLev: Int, favPct: Int) {
        encountered = enc
        encounterDate = encDate
        favorLevel = favLev
        favorExpPercent = favPct
    }
}
