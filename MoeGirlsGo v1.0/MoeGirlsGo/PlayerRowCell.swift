//
//  PlayerRowCell.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2019/1/11.
//  Copyright © 2019年 AldebaRain. All rights reserved.
//

import UIKit

class PlayerRowCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var headImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
