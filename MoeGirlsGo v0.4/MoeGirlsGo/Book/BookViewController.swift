//
//  BookViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/12/4.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var catalogSeg: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置UICollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        // 分类说明
        headLabel.text = "萌娘类别X的说明"
    }
    
    // 每转换类别
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        collectionView.reloadData() // 刷新数据
    }
    
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
        let cellNum = MoeGirlDataManager.shared.getGroupGirlNum(groupId: catalogSeg.selectedSegmentIndex)
        print(catalogSeg.selectedSegmentIndex)
        print(cellNum)
        return cellNum
    }
    
    // 设置具体每条数据的item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationCell
        cell.backgroundColor = UIColor(red: CGFloat(arc4random() % 255) / 255.0,
                                       green: CGFloat(arc4random() % 255) / 255.0,
                                       blue: CGFloat(arc4random() % 255) / 255.0,
                                       alpha: 0.3)
        // 该类别全部萌娘
        let groupGirlProperties = MoeGirlDataManager.shared.getGroupGirls(groupId: catalogSeg.selectedSegmentIndex)
        let index = indexPath.row
        cell.girlPortraitView.image = UIImage(named: "MoeGirl\(groupGirlProperties[index].girlId)")
        cell.nameLabel.text = groupGirlProperties[index].girlName
        cell.rareLevelLabel.text = "\(groupGirlProperties[index].girlRareLevel)"
        return cell
    }
    
    // 每选中一个item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

