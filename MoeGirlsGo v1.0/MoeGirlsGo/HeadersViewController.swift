//
//  HeadersViewController.swift
//  MoeGirlsGo
//
//  Created by apple on 2019/1/11.
//  Copyright © 2019年 AldebaRain. All rights reserved.
//

import UIKit

class HeadersViewController: UIViewController {

    @IBOutlet weak var headerBtn0: UIButton!
    @IBOutlet weak var headerBtn1: UIButton!
    @IBOutlet weak var headerBtn2: UIButton!
    @IBOutlet weak var headerBtn3: UIButton!
    @IBOutlet weak var headerBtn4: UIButton!
    @IBOutlet weak var headerBtn5: UIButton!
    @IBOutlet weak var headerBtn6: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerBtn0.setBackgroundImage(#imageLiteral(resourceName: "Head0"), for: .normal)
        headerBtn1.setBackgroundImage(#imageLiteral(resourceName: "Head1"), for: .normal)
        headerBtn2.setBackgroundImage(#imageLiteral(resourceName: "Head2"), for: .normal)
        headerBtn3.setBackgroundImage(#imageLiteral(resourceName: "Head3"), for: .normal)
        headerBtn4.setBackgroundImage(#imageLiteral(resourceName: "Head4"), for: .normal)
        headerBtn5.setBackgroundImage(#imageLiteral(resourceName: "Head5"), for: .normal)
        headerBtn6.setBackgroundImage(#imageLiteral(resourceName: "Head6"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeHeader0(_ sender: UIButton) {
        currentPlayer.setHead(headId: .DEFAULT)
    }
    
    @IBAction func changeHeader1(_ sender: UIButton) {
        currentPlayer.setHead(headId: .ONE)
    }
    
    @IBAction func changeHeader2(_ sender: UIButton) {
        currentPlayer.setHead(headId: .TWO)
    }
    
    @IBAction func changeHeader3(_ sender: UIButton) {
        currentPlayer.setHead(headId: .THREE)
    }
    
    @IBAction func changeHeader4(_ sender: UIButton) {
        currentPlayer.setHead(headId: .FOUR)
    }
    
    @IBAction func changeHeader5(_ sender: UIButton) {
        currentPlayer.setHead(headId: .FIVE)
    }
    
    @IBAction func changeHeader6(_ sender: UIButton) {
        currentPlayer.setHead(headId: .SIX)
    }
    
}
