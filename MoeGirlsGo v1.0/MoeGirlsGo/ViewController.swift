//
//  ViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/21.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerHeadBtn: UIButton!
    
    override func loadView() {
        super.loadView()
        
        print("Loading Current...")
        
        // 初始化图鉴（如果是第一次玩游戏的话）
        CoreDataManager.shared.initBook()
        // 加载图鉴
        CoreDataManager.shared.loadBook()
        // 加载成就
        CoreDataManager.shared.loadAchievement()
        // 加载地图标注
        CoreDataManager.shared.loadAllAnnotations()
        
        print("Load Current Success !")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerHeadBtn.setBackgroundImage(currentPlayer.head, for: .normal)
        
    }


}

