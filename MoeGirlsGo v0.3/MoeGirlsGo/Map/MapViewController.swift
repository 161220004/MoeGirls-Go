//
//  MapViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/21.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit

let APIKey = "9cc2da3d7910877cc76261b5ff24a5dd"

class MapViewController: UIViewController, MAMapViewDelegate {

    var mapView: MAMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置APIKey
        AMapServices.shared()?.apiKey = APIKey
        // 设置权限
        if (CLLocationManager.authorizationStatus() == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 使用代码方式添加地图控件
        mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        self.view.addSubview(mapView)
        self.view.sendSubviewToBack(mapView) // 置于底层
        // 显示用户小蓝点
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.followWithHeading
        // 自定义地图
        mapView.setZoomLevel(18, animated: true) // 缩放级别
        mapView.setCameraDegree(60, animated: true, duration: 0.5) // 倾斜角
        // 自定义小蓝点
        let myRep = MAUserLocationRepresentation() // 小蓝点格式
        myRep.showsAccuracyRing = true // 显示精度圈
        myRep.fillColor = UIColor(red: 0.518, green: 0.094, blue: 0.447, alpha: 0.3) // 精度圈颜色
        myRep.showsHeadingIndicator = false // 不显示方向指示
        myRep.locationDotFillColor = UIColor(red: 0.518, green: 0.094, blue: 0.447, alpha: 0.9) // 小蓝点颜色
        myRep.enablePulseAnnimation = true // 小蓝点动画
        mapView.update(myRep)
    }
    
    // 点击“返回”按钮
    @IBAction func goBack(_ sender: UIButton) {
        // 回到主界面
        dismiss(animated: true, completion: nil)
    }
    
    // 点击“刷新”按钮
    @IBAction func refresh(_ sender: UIButton) {
        // 清空数据
        girlAnnotations.removeAll()
        //CoreDataManager.shared.deleteAll()
        // 刷新萌娘地图标注
        let annoNum = randomInt(min: 20, max: 40)
        for i in 1...annoNum {
            // 临时存储
            let annoMoeGirl = MoeGirlAnnotation()
            annoMoeGirl.setRandom() // 获取一个标注的随机值
            girlAnnotations[i] = annoMoeGirl // 添加到地图标注字典
            // 持久存储
            //CoreDataManager.shared.insertData(girlAnnotation: annoMoeGirl)
            // 添加标注
            let pMoeGirl = MAPointAnnotation() // 大头针标注
            pMoeGirl.coordinate.latitude = annoMoeGirl.coordinate.latitude
            pMoeGirl.coordinate.longitude = annoMoeGirl.coordinate.longitude
            pMoeGirl.title = annoMoeGirl.girlName
            pMoeGirl.subtitle = annoMoeGirl.girlDescription
            mapView.addAnnotation(pMoeGirl) // 显示标注
        }
    }
    
    // 每刷新用户位置
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        myLocation = userLocation.location
    }
    
    // 回调，标注样式
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        // 仅仅处理选中的，且不是当前位置的annotation，防止小蓝点被覆盖
        if annotation.coordinate.latitude == myLocation?.coordinate.latitude &&
        annotation.coordinate.longitude == myLocation?.coordinate.longitude {
            return nil
        }
        let pointReuseIndetifier = "pointReuseIndetifier"
        var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
        if annotationView == nil {
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
        }
        annotationView!.animatesDrop = true // 有下落动画
        annotationView!.isDraggable = false // 不可拖拽
        // 显示按钮；点击按钮才会进入AR界面
        annotationView!.canShowCallout = true
        annotationView!.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
        // 标注大头针颜色：0红，1绿，2紫
        annotationView!.pinColor = MAPinAnnotationColor(rawValue: 2)!
        return annotationView!
    }
    
    // 每选中一个标注
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        // 点击当前位置
        if view.annotation.coordinate.latitude == myLocation?.coordinate.latitude &&
        view.annotation.coordinate.longitude == myLocation?.coordinate.longitude {
            print("Select my Location !")
            // 恢复旋转模式
            mapView.userTrackingMode = MAUserTrackingMode.followWithHeading
        }
    }
    
    // 每点击一个标注
    func mapView(_ mapView: MAMapView!, didAnnotationViewTapped view: MAAnnotationView!) {
    }
    
    // 获取当前萌娘类型
    private func getGirlId(annotationView view: MAAnnotationView!) -> Int {
        for (_, girlAnno) in girlAnnotations {
            if let pTmp = view.annotation {
                if pTmp.coordinate.latitude == girlAnno.coordinate.latitude &&
                    pTmp.coordinate.longitude == girlAnno.coordinate.longitude {
                    // 得到当前标注
                    return girlAnno.girlId
                }
            }
        }
        return 1
    }
    
    // 当点击标注的按钮时
    func mapView(_ mapView: MAMapView!, annotationView view: MAAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let pTmp = view.annotation {
            if pTmp.coordinate.latitude == myLocation?.coordinate.latitude &&
                pTmp.coordinate.longitude == myLocation?.coordinate.longitude {
                return // 点击用户当前位置，直接返回
            }
            // 点击萌娘出现的位置
            if MAMetersBetweenMapPoints(MAMapPointForCoordinate(pTmp.coordinate),
                                        MAMapPointForCoordinate(myLocation!.coordinate))
                <= catchRange { // 在最小捕捉范围之内
                // 获取当前萌娘类型
                girlIdNow = getGirlId(annotationView: view)
                // 从地图移除该标注
                mapView.removeAnnotation(pTmp)
                // 加载摄像头视图
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ARViewController = storyboard.instantiateViewController(withIdentifier: "CameraViewController")
                present(ARViewController, animated: true, completion: nil)
            }
            else { // 超出范围，弹出警告
                let alertView = UIAlertController(title: "太远啦", message: "近视的我并没有看见萌娘", preferredStyle: .alert)
                let actionKnow = UIAlertAction(title: "知道了", style: .cancel,
                                               handler: { (UIAlertAction) -> Void in print("选择失败") })
                alertView.addAction(actionKnow)
                present(alertView, animated: true, completion: nil)
            }
        }
    }
}
