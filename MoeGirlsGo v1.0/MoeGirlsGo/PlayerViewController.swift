//
//  PlayerViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2019/1/11.
//  Copyright © 2019年 AldebaRain. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerTableView: UITableView!
    
    @IBOutlet weak var choosePlayerBtn: UIButton!
    
    //@IBOutlet weak var deletePlayerBtn: UIButton!
    
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTableView.dataSource = self
        playerTableView.delegate = self
        playerTableView.backgroundColor = UIColor.black
        playerTableView.isHidden = true
        // 未选定角色时禁用“删除角色”和“进入游戏”
        //deletePlayerBtn.isEnabled = false
        startBtn.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 选择角色
    @IBAction func choosePlayer(_ sender: UIButton) {
        // 若右侧表单隐藏则将其打开
        if playerTableView.isHidden {
            playerTableView.isHidden = false
        }
        else {// 若右侧表单打开则将其隐藏
            playerTableView.isHidden = true
        }
    }
    
    /* 删除角色
    @IBAction func deletePlayer(_ sender: UIButton) {
        // 先清空该角色的数据库
        CoreDataManager.shared.deleteAllAnnotations()
        CoreDataManager.shared.deleteBook()
        CoreDataManager.shared.deleteAchievement()
        CoreDataManager.shared.deletePlayer(playerNo: currentPlayer.no)
        // 再刷新players临时数组
        CoreDataManager.shared.loadAllPlayers()
        // 再清空并刷新表单
        currentPlayer = Player()
        choosePlayerBtn.setTitle("选 择 角 色", for: .normal)
        startBtn.isEnabled = false
        deletePlayerBtn.isEnabled = false
        playerTableView.reloadData()
    }
    */
}

extension PlayerViewController: UITableViewDataSource,UITableViewDelegate {
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // 每行cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    // 设置每个cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowcell = tableView.dequeueReusableCell(withIdentifier: "rowcell", for: indexPath) as! PlayerRowCell
        rowcell.backgroundColor = UIColor.black
        let index = indexPath.row
        var isEmpty = true
        for player in players {
            if index + 1 == player.no { // 是存档
                rowcell.headImg.image = player.head
                rowcell.nameLabel.text = player.name
                isEmpty = false
            }
        }
        if isEmpty { // 是空档
            rowcell.headImg.image = UIImage(named: "MoeGirl0Portrait")
            rowcell.nameLabel.text = " "
        }
        return rowcell
    }
    
    // 当选中一个cell时
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        var isEmpty = true
        for player in players {
            if index + 1 == player.no { // 是存档
                choosePlayerBtn.setTitle(player.name, for: .normal)
                startBtn.isEnabled = true
                //deletePlayerBtn.isEnabled = true
                isEmpty = false
                // 加载数据到临时区
                currentPlayer = Player(player: player)
            }
        }
        if isEmpty { // 是空档
            choosePlayerBtn.setTitle("选 择 角 色", for: .normal)
            startBtn.isEnabled = false
            //deletePlayerBtn.isEnabled = false
            
            // 弹出消息栏要求填写玩家信息
            var inputName: UITextField = UITextField();
            let alertControl = UIAlertController.init(title: "创建角色", message: "", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "创建", style: .default) {
                (action:UIAlertAction) -> () in
                if inputName.text != "" {
                    print("创建角色\(String(describing: inputName.text))成功")
                    // 开始创建角色，将数据初始化并保存至临时区和数据库，并设定当前角色
                    currentPlayer = Player()
                    currentPlayer.setNo(playerNo: PlayerRange(rawValue: (index % MAXPlayerNum + 1))!)
                    currentPlayer.setName(playerName: inputName.text!)
                    players.append(currentPlayer)
                    CoreDataManager.shared.insertPlayer(player: currentPlayer)
                    // 创建完成，刷新显示在cell中
                    self.choosePlayerBtn.setTitle(inputName.text, for: .normal)
                    self.startBtn.isEnabled = true
                    self.playerTableView.reloadData()
                }
                else { // 不能创建空名的角色
                    let failAlertControl = UIAlertController.init(title: "创建失败", message: "角色名不能为空", preferredStyle:.alert)
                    let getIt = UIAlertAction.init(title: "好的", style: UIAlertActionStyle.cancel) {
                        (action:UIAlertAction) -> () in
                        print("处理完成\(action)")
                    }
                    failAlertControl.addAction(getIt);
                    self.present(failAlertControl, animated: true, completion: nil)
                }
            }
            let cancel = UIAlertAction.init(title: "取消", style:.cancel) {
                (action:UIAlertAction) -> () in
                print("取消创建角色")
            }
            alertControl.addAction(ok)
            alertControl.addAction(cancel)
            // 添加textField输入框
            alertControl.addTextField {
                (textField) in
                // 设置传入的textField为初始化UITextField
                inputName = textField
                inputName.placeholder = "请输入角色名"
            }
            //设置到当前视图
            self.present(alertControl, animated: true, completion: nil)
        }
    }
    
}
