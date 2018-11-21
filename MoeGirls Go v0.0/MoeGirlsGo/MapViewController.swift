//
//  MapViewController.swift
//  MoeGirlsGo
//
//  Created by 曹洋笛 on 2018/11/19.
//  Copyright © 2018年 AldebaRain. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation // 定位框架

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager() // 创建位置管理器
    var myLocation: CLLocation?
    var selectedAnnotation: MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 请求用户授权使用位置
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        // 开启定位服务
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        // 设置地图效果
        mapView.mapType = MKMapType.hybrid // 行政卫星地图
        mapView.isRotateEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
        // 追踪用户位置
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
    }
}

extension MapViewController: MKMapViewDelegate {
    // 每刷新用户位置
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    }
}

extension MapViewController: CLLocationManagerDelegate {
    // 位置改变时回调方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    // 方向改变时回调方法
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    }
}
