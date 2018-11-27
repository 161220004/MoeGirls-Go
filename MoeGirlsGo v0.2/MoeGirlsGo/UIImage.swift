//
//  UIImage.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/27.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit

// 扩展UIImage，增加重设图片大小的方法
extension UIImage {
    func reSizeImage(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImg
    }
    // 等比例缩放
    func scaleImage(newRate: CGFloat) -> UIImage {
        let newSize = CGSize(width: self.size.width * newRate, height: self.size.height * newRate)
        return reSizeImage(newSize: newSize)
    }
}
