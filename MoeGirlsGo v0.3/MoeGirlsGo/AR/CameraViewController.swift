//
//  CameraViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/23.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class CameraViewController: UIViewController, ARSKViewDelegate {
    
    var timer: Timer! // 计时器
    
    @IBOutlet weak var sceneView: ARSKView!
    
    @IBOutlet weak var CountDownSlider: UISlider!
    
    @IBOutlet weak var SearchBtn: UIButton!
    
    @IBOutlet weak var TapNumTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 个性化界面
        CountDownSlider.setThumbImage(UIImage(named: "CountDownImg")?.scaleImage(newRate: 0.5), for: .normal)
        CountDownSlider.isContinuous = true
        CountDownSlider.minimumValue = 0
        CountDownSlider.maximumValue = MAXCatchTime
        CountDownSlider.value = CountDownSlider.maximumValue
        // 协议
        sceneView.delegate = self
        // debug
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true // 锚点个数
        // 加载'Scene.sks'
        let scene = Scene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        sceneView.presentScene(scene)
        // 防止锁屏
        UIApplication.shared.isIdleTimerDisabled = true
        // 初始化全局变量
        initGlobalInCameraView()
        // 启用计时器，控制每0.01秒执行一次countDown方法
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // session配置
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause() // 暂停AR
        UIApplication.shared.isIdleTimerDisabled = false
        // 复原全局变量
        initGlobalInCameraView()
        // 停止计时器
        guard let tmpTimer = self.timer else{ return }
        tmpTimer.invalidate()
    }
    
    @objc func countDown() {
        // 已经找到萌娘时，开始倒计时
        if finishSearch == true && finishCatch == false {
            if countDownTime > 0 && tapNum < MAXTapNum { // 正在捕捉
                TapNumTxt.text = "点击：\(tapNum)/\(MAXTapNum)"
                CountDownSlider.value = countDownTime
                countDownTime -= 0.01
                SearchBtn.setTitle("发现萌娘！请快速点击～", for: .normal)
            }
            else if countDownTime > 0 && tapNum >= MAXTapNum { // 捕捉成功
                finishCatch = true
                TapNumTxt.text = "点击：\(MAXTapNum)/\(MAXTapNum)"
                SearchBtn.setTitle("你和萌娘成为了好朋友<^_^>", for: .normal)
                // 设置按钮不可选
                SearchBtn.isEnabled = false
            }
            else /* if countDownTime <= 0 && tapNum < MAXTapNum */ { // 捕捉失败
                finishCatch = true
                TapNumTxt.text = "点击：\(tapNum)/\(MAXTapNum)"
                SearchBtn.setTitle("你被萌娘嫌弃了<T_T>", for: .normal)
                // 设置按钮不可选
                SearchBtn.isEnabled = false
            }
        }
        //else if finishCatch == true {
            // 捕捉结束后的行为
        //}
    }
    
    // MARK: - Click Button Action
    
    // 点击“开始搜索”按钮
    @IBAction func startSearch(_ sender: UIButton) {
        startToSearch = true
        SearchBtn.setTitle("搜索中...", for: .normal)
    }
    
    // 点击“返回”按钮
    @IBAction func goBack(_ sender: UIButton) {
        // 回到地图界面
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refresh(_ sender: UIButton) {
    }
    
    // MARK: - ARSKViewDelegate
    // 对于每一个锚点
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        //let labelNode = SKLabelNode(text: "👾")
        let girlNode = SKSpriteNode(imageNamed: "MoeGirl\(girlIdNow)")
        girlNode.name = "MoeGirl"
        return girlNode;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
}
