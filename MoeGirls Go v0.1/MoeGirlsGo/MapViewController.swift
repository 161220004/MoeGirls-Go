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
    var myLocation: CLLocation?
    
    let myRep = MAUserLocationRepresentation() // 小蓝点格式
    let pMoeGirl = MAPointAnnotation() // 大头针标注
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置APIKey
        AMapServices.shared()?.apiKey = APIKey
        // 使用代码方式添加地图控件
        mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        self.view.addSubview(mapView)
        // 显示用户小蓝点
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.followWithHeading
        // 自定义地图
        mapView.setZoomLevel(18, animated: true) // 缩放级别
        mapView.setCameraDegree(60, animated: true, duration: 0.5) // 倾斜角
        // 自定义小蓝点
        myRep.showsAccuracyRing = true // 显示精度圈
        myRep.fillColor = UIColor(red: 0.61, green: 0.77, blue: 0.89, alpha: 0.3)
        myRep.enablePulseAnnimation = true // 小蓝点动画
        myRep.showsHeadingIndicator = true // 显示方向
        mapView.update(myRep)
        
        // 放置大头针
        //let tmpLatitude = myLocation?.coordinate.latitude ?? 0 + 1
        //let tmpLongitude = myLocation?.coordinate.longitude ?? 0 + 1
        let tmpLatitude = 32.115
        let tmpLongitude = 118.958
        pMoeGirl.coordinate = CLLocationCoordinate2D(latitude: tmpLatitude, longitude: tmpLongitude)
        pMoeGirl.title = "萌娘"
        pMoeGirl.subtitle = "小白"
        mapView.addAnnotation(pMoeGirl)
        
    }
    
    // 每刷新用户位置
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        myLocation = userLocation.location
    }
    
    // 回调，标注样式
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.coordinate.latitude == pMoeGirl.coordinate.latitude &&
            annotation.coordinate.longitude == pMoeGirl.coordinate.longitude {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            annotationView!.animatesDrop = true
            annotationView!.isDraggable = false
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
            annotationView!.pinColor = MAPinAnnotationColor(rawValue: 2)!
            return annotationView!
        }
        return nil
    }
    
    // 每选中一个标注
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        // 点击当前位置
        if view.annotation.coordinate.latitude == myLocation?.coordinate.latitude &&
            view.annotation.coordinate.longitude == myLocation?.coordinate.longitude {
            // 恢复旋转模式
            mapView.userTrackingMode = MAUserTrackingMode.followWithHeading
            myRep.showsHeadingIndicator = true
            mapView.update(myRep)
        }
    }
}
