//
//  BookViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/4.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    // 当前页面类别中的萌娘
    var groupGirlPropInfo = [MoeGirlPropInfo]()
    
    // 选中的萌娘，用于跳转传值
    var girlPropInfoNow = MoeGirlPropInfo()
    
    @IBOutlet weak var catalogSeg: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置UICollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        // UICollectionView的初始cells
        groupGirlPropInfo.append(contentsOf: getGroupGirls(groupId: catalogSeg.selectedSegmentIndex))
    }
    
    // 每转换类别
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        // 该类别全部萌娘
        groupGirlPropInfo.removeAll()
        groupGirlPropInfo.append(contentsOf: getGroupGirls(groupId: catalogSeg.selectedSegmentIndex))
        collectionView.reloadData() // 刷新数据
    }
    
    // 按Id排序
    @IBAction func sortGroupById(_ sender: UIButton) {
        groupGirlPropInfo.sort(by: { $0.girlId < $1.girlId })
        collectionView.reloadData() // 刷新数据
    }
    
    // 按好感度排序
    @IBAction func sortGroupByFavor(_ sender: UIButton) {
        groupGirlPropInfo.sort(by: { (100 * $0.favorLevel + $0.favorExpPercent) > (100 * $1.favorLevel + $1.favorExpPercent) })
        collectionView.reloadData() // 刷新数据
    }
    
    // 按FightLevel排序
    @IBAction func sortGroupByPower(_ sender: UIButton) {
        groupGirlPropInfo.sort(by: { $0.girlFightLevel > $1.girlFightLevel })
        collectionView.reloadData() // 刷新数据
    }
    
    // 按RareLevel排序
    @IBAction func sortGroupByRare(_ sender: UIButton) {
        groupGirlPropInfo.sort(by: { $0.girlRareLevel > $1.girlRareLevel })
        collectionView.reloadData() // 刷新数据
    }
    
    // 点击“返回”按钮
    @IBAction func goBack(_ sender: UIButton) {
        // 回到主界面
        dismiss(animated: true, completion: nil)
    }

}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 分区内的item数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 个数为计算该类别的萌娘数
        let cellNum = getGroupGirlNum(groupId: catalogSeg.selectedSegmentIndex)
        return cellNum
    }
    
    // head高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 70)
    }
    
    // 设置具体每条数据的item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationCell
        cell.backgroundColor = UIColor(red: CGFloat(arc4random() % 255) / 255.0,
                                       green: CGFloat(arc4random() % 255) / 255.0,
                                       blue: CGFloat(arc4random() % 255) / 255.0,
                                       alpha: 0.3)
        let index = indexPath.row
        // 如果是认识的，写入信息
        if groupGirlPropInfo[index].encountered {
            cell.girlPortraitView.image = UIImage(named: "MoeGirl\(groupGirlPropInfo[index].girlId)Portrait")
            cell.idLabel.text = "\(groupGirlPropInfo[index].girlId)"
            cell.nameLabel.text = groupGirlPropInfo[index].girlName
            if let tmpRareImg = UIImage(named: "RareLevel\(groupGirlPropInfo[index].girlRareLevel)") {
                cell.rareLevelImg.image = tmpRareImg.scaleImage(newHeight: 12)
            }
            if let tmpFightImg = UIImage(named: "FightLevel\(groupGirlPropInfo[index].girlFightLevel)") {
                cell.fightLevelImg.image = tmpFightImg.scaleImage(newHeight: 12)
            }
        }
        else { // 从未遇到的萌娘
            cell.girlPortraitView.image = UIImage(named: "MoeGirl0Portrait")
            cell.idLabel.text = "\(groupGirlPropInfo[index].girlId)"
            cell.nameLabel.text = "? ? ?"
        }
        return cell
    }
    
    // 每选中一个item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        // 如果是认识的，跳转到详细信息界面
        if groupGirlPropInfo[index].encountered {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let infoViewController = storyboard.instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
            infoViewController.girlPropInfoNow.setFix(propinfo: groupGirlPropInfo[index]) // 传值
            present(infoViewController, animated: true, completion: nil)
        }
    }
    
    // 设定header和footer的方法，根据kind不同进行不同的判断即可
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "head", for: indexPath)  as! InformationHead
        headView.headLabel.text = "萌娘类别\(catalogSeg.selectedSegmentIndex)的说明"
        return headView
    }
}

