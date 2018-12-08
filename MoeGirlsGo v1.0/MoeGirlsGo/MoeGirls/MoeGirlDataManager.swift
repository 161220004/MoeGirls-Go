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
    
}
