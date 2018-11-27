//
//  Scene.swift
//  HelloAR
//
//  Created by 曹洋笛 on 2018/11/26.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    // 场景初始化后立即调用
    override func sceneDidLoad() {
    }
    
    // 在视图显示场景后立即调用
    override func didMove(to view: SKView) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        //createMoeGirl()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if startToSearch == true && finishSearch == false {
            createMoeGirl()
        }
        else {
            tapNum += 1
        }
    }
 
    // 随机浮点数
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    func createMoeGirl() {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        // 判断镜头的位置
        if sceneView.session.currentFrame != nil {
            //if hasGirl == false { // 保证只生成一个萌娘
            // 创建一个摄像头前 0.5 ~ 1.5 米随机位置的转换
            var translation = matrix_identity_float4x4
            let rad360 = 2.0 * Float.pi // 360的弧度
            let rotateX = simd_float4x4(SCNMatrix4MakeRotation(rad360 * randomFloat(min: 0.0, max: 1.0), 1, 0, 0))
            let rotateY = simd_float4x4(SCNMatrix4MakeRotation(rad360 * randomFloat(min: 0.0, max: 1.0), 0, 1, 0))
            let rotation = simd_mul(rotateX, rotateY)
            translation.columns.3.z = -0.5 - randomFloat(min: 0.0, max: 1.0) // 范围 0.5 ~ 1.5 m
            let transform = simd_mul(rotation, translation)
            // 添加锚点
            let archor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: archor)
            finishSearch = true
            //}
        }
    }
}
