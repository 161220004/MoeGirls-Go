//
//  MoeGirlsManager.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/5.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation

class MoeGirlDataManager: NSObject {
    
    static let shared = MoeGirlDataManager() // 实例
    
    // 加载所有萌娘的公式书到临时数据
    func loadAllProperties() {
        for i in 1...MoeGirlTypeNum {
            girlProperties[i] = MoeGirlProperty(id: i)
        }
    }
    
    // 计算某个类别Group的萌娘个数
    func getGroupGirlNum(groupId: Int) -> Int {
        var count = 0
        for i in 1...MoeGirlTypeNum {
            if girlProperties[i]?.girlGroupId == groupId {
                count += 1
            }
        }
        return count
    }
    
    // 得到某个类别Group的全部萌娘
    func getGroupGirls(groupId: Int) -> [MoeGirlProperty] {
        var groupGirlProperties = [MoeGirlProperty]()
        for i in 1...MoeGirlTypeNum {
            if girlProperties[i]!.girlGroupId == groupId {
                groupGirlProperties.append(girlProperties[i]!)
            }
        }
        return groupGirlProperties
    }
}
