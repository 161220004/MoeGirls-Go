//
//  PlayerManagerViewController.swift
//  MoeGirlsGo
//
//  Created by apple on 2019/1/11.
//  Copyright © 2019年 AldebaRain. All rights reserved.
//

import UIKit

class PlayerManagerViewController: UIViewController {

    @IBOutlet weak var playerHeadImg: UIImageView!
    
    @IBOutlet weak var completionLabel: UILabel!
    
    @IBOutlet weak var bestFriendLabel: UILabel!
    
    @IBOutlet weak var encounterNumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置头像
        playerHeadImg.image = currentPlayer.head
        // 设置成就数据
        encounterNumLabel.text = "\(totalEncounterNum) 次"
        // 计算图鉴完成度和最大亲密度的萌娘
        var countCompletion = 0
        var bestFriendId = 1
        var maxFavor = girlBook[1]!.favorLevel * 100 + girlBook[1]!.favorExpPercent
        for i in 1...MoeGirlTypeNum {
            if girlBook[i]!.encountered {
                countCompletion += 1
            }
            let tmpFavor = girlBook[i]!.favorLevel * 100 + girlBook[i]!.favorExpPercent
            if tmpFavor > maxFavor {
                bestFriendId = i
                maxFavor = tmpFavor
            }
        }
        completionLabel.text = "\(countCompletion) / \(MoeGirlTypeNum)"
        if countCompletion == 0 {
            bestFriendLabel.text = "-"
        }
        else {
            bestFriendLabel.text = "\(girlProperties[bestFriendId]!.girlName)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
