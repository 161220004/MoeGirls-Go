//
//  MoeGirls.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/4.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation

class PlistManager: NSObject {
    
    static func getPlist(_ plist: String) -> Any? {
        guard let filePath = Bundle.main.path(forResource: plist, ofType: "plist"),
            let data = FileManager.default.contents(atPath: filePath) else { return nil }
        do {
            return try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
        } catch {
            return nil
        }
    }
}
