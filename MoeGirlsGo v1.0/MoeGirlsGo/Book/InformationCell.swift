//
//  CollectionViewCell.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/5.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit

class InformationCell: UICollectionViewCell {
    
    @IBOutlet weak var girlPortraitView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rareLevelImg: UIImageView!
    
    @IBOutlet weak var fightLevelImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

