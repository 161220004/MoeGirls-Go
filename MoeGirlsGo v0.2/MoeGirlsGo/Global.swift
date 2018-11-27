//
//  Global.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/27.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import Foundation

let MAXCatchTime: Float = 10.0
let MAXTapNum = 50

var startToSearch: Bool = false
var finishSearch: Bool = false
var finishCatch: Bool = false
var countDownTime: Float = MAXCatchTime
var tapNum: Int = 0

func initGlobalInCameraView() {
    startToSearch = false
    finishSearch = false
    finishCatch = false
    countDownTime = MAXCatchTime
    tapNum = 0
}
