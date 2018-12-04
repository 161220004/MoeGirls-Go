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
        if finishCatch == true {
            let node = self.childNode(withName: "MoeGirl")
            // 添加一组动作序列，以淡出的方式移除萌娘
            let fadeAnim = SKAction.fadeOut(withDuration: 1.5)
            let removeNode = SKAction.removeFromParent()
            node?.run(SKAction.sequence([fadeAnim, removeNode]))
        }
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if startToSearch == true && finishSearch == false {
            createMoeGirl()
        }
        else {
            let node = self.childNode(withName: "MoeGirl")
            if let nodePos = node?.position {
                // 只有萌娘在屏幕范围内，才计数tap
                if nodePos.x < view!.frame.width && nodePos.x > 0
                    && nodePos.y < view!.frame.height && nodePos.y > 0{
                    tapNum += 1
                }
            }
        }
    }
 
    func createMoeGirl() {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        // 判断镜头的位置
        if sceneView.session.currentFrame != nil {
            // 创建一个摄像头前最近到最远距离的全方位随机位置的转换
            var translation = matrix_identity_float4x4
            let rad360 = 2.0 * Float.pi // 360的弧度
            let rotateX = simd_float4x4(SCNMatrix4MakeRotation(rad360 * randomFloat(min: 0.0, max: 1.0), 1, 0, 0))
            let rotateY = simd_float4x4(SCNMatrix4MakeRotation(rad360 * randomFloat(min: 0.0, max: 1.0), 0, 1, 0))
            let rotation = simd_mul(rotateX, rotateY)
            // 范围 MIN ~ MAX m
            translation.columns.3.z =  -randomFloat(min: MINDistanceFromCamera, max: MAXDistanceFromCamera)
            let transform = simd_mul(rotation, translation)
            // 添加锚点
            let archor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: archor)
            finishSearch = true
        }
    }
}
