//
//  MoeGirlProperty.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/5.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation

// 来自MoeGirls.plist，是某一个萌娘的公式书
class MoeGirlProperty: NSObject {
    
    var girlId: Int = 1
    var girlGroupId: Int = 0
    var girlName: String = "-"
    var girlDescription: String = "-"
    var girlDetail: String = "-"
    var girlRareLevel: Int = 0
    var girlFightLevel: Int = 0
    
    init(id: Int) {
        super.init()
        girlId = id
        // 读取plist
        guard let properties = PlistManager.getPlist("MoeGirls") as? [String: Any],
            let girlProperty = properties["MoeGirl\(girlId)"] as? [String: Any] else { return }
        girlGroupId = girlProperty["GroupId"] as! Int
        girlName = girlProperty["Name"] as! String
        girlDescription = girlProperty["Description"] as! String
        girlDetail = girlProperty["Detail"] as! String
        girlRareLevel = girlProperty["RareLevel"] as! Int
        girlFightLevel = girlProperty["FightLevel"] as! Int
    }
}
