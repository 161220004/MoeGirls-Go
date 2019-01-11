//
//  InformationViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/7.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    // 选中的萌娘，从BookViewController中得到传值
    var girlPropInfoNow = MoeGirlPropInfo()
    // 是从图鉴界面过来还是AR界面过来
    var fromARView = false
    
    @IBOutlet weak var scrollView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var girlPortraitView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var rareLevelImg: UIImageView!
    
    @IBOutlet weak var fightLevelImg: UIImageView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var encounterLabel: UILabel!
    
    @IBOutlet weak var favorLabel: UILabel!
    
    @IBOutlet weak var cheerImg: UIImageView!
    
    @IBOutlet weak var appearanceBtn: UIButton!
    
    @IBOutlet weak var albumBtn: UIButton!
    
    @IBOutlet weak var storyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置属性
        detailLabel.numberOfLines = 0
        // 填写萌娘信息
        nameLabel.text = girlPropInfoNow.girlName
        girlPortraitView.image = UIImage(named: "MoeGirl\(girlPropInfoNow.girlId)Portrait")
        idLabel.text = "\(girlPropInfoNow.girlId)"
        groupLabel.text = "\(girlPropInfoNow.girlGroupId)"
        if let tmpRareImg = UIImage(named: "RareLevel\(girlPropInfoNow.girlRareLevel)") {
            rareLevelImg.image = tmpRareImg.scaleImage(newHeight: 18)
        }
        if let tmpFightImg = UIImage(named: "FightLevel\(girlPropInfoNow.girlFightLevel)") {
            fightLevelImg.image = tmpFightImg.scaleImage(newHeight: 18)
        }
        // 详细信息的ScrollView
        let detailText = girlPropInfoNow.girlDetail.components(separatedBy: "<br>")
        detailLabel.text = detailText.joined(separator: "\n")
        var favorText = ""
        for i in 0...MAXFavorLevel {
            if girlPropInfoNow.favorLevel > i {
                favorText += "♥️"
            }
            else {
                favorText += "⭕️"
            }
        }
        favorText += "  "
        for i in stride(from: 0, to: 100, by: 10) {
            if girlPropInfoNow.favorExpPercent > i {
                favorText += "◾️"
            }
            else {
                favorText += "◽️"
            }
        }
        favorLabel.text = favorText + "(\(girlPropInfoNow.favorExpPercent)%)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日相遇"
        encounterLabel.text = dateFormatter.string(from: girlPropInfoNow.encounterDate)
        
        // 如果是从AR跳转的，不显示按钮，且显示烟花；否则反之
        if fromARView {
            appearanceBtn.isHidden = true
            albumBtn.isHidden = true
            storyBtn.isHidden = true
        }
        else {
            cheerImg.isHidden = true
            self.view.sendSubview(toBack: cheerImg)
        }
    }
    
    // 点击“返回”按钮
    @IBAction func goBack(_ sender: UIButton) {
        if fromARView {
            // 回到地图界面MapViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController")
            present(mapViewController, animated: true, completion: nil)
        }
        else {
            // 回到图鉴界面
            dismiss(animated: true, completion: nil)
        }
    }

}
