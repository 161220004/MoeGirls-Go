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
    // 设置图片大小
    func reSizeImage(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImg
    }
    // 等比例缩放
    func scaleImage(newRate: CGFloat) -> UIImage {
        let newSize = CGSize(width: size.width * newRate, height: size.height * newRate)
        return reSizeImage(newSize: newSize)
    }
    func scaleImage(newWidth: CGFloat) -> UIImage {
        let newRate = newWidth / size.width
        return scaleImage(newRate: newRate)
    }
    func scaleImage(newHeight: CGFloat) -> UIImage {
        let newRate = newHeight / size.height
        return scaleImage(newRate: newRate)
    }
}
