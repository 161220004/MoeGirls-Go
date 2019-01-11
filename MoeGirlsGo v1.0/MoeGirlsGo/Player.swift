//
//  Player.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2019/1/11.
//  Copyright © 2019年 AldebaRain. All rights reserved.
//

import Foundation

// 玩家（最多5个）
enum PlayerRange: Int {
    case ONE = 1, TWO, THREE, FOUR, FIVE
}

// 头像（最多7个）
enum HeadRange: Int {
    case DEFAULT = 0, ONE, TWO, THREE, FOUR, FIVE, SIX
}

class Player: NSObject {
    var no: Int
    var name: String
    var hid: Int
    var head: UIImage
    
    override init() {
        no = 1
        name = "? ? ?"
        hid = 0
        head = #imageLiteral(resourceName: "Head0")
    }
    
    init(player: Player) {
        no = player.no
        name = player.name
        hid = player.hid
        head = player.head
    }
    
    func setNo(playerNo: PlayerRange) {
        no = playerNo.rawValue
    }
    
    func setName(playerName: String) {
        name = playerName
    }
    
    func setHead(headId: HeadRange) {
        hid = headId.rawValue
        switch headId {
        case .ONE:
            head = #imageLiteral(resourceName: "Head1")
        case .TWO:
            head = #imageLiteral(resourceName: "Head2")
        case .THREE:
            head = #imageLiteral(resourceName: "Head3")
        case .FOUR:
            head = #imageLiteral(resourceName: "Head4")
        case .FIVE:
            head = #imageLiteral(resourceName: "Head5")
        case .SIX:
            head = #imageLiteral(resourceName: "Head6")
        default:
            head = #imageLiteral(resourceName: "Head0")
        }
    }
    
}
