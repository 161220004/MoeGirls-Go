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
    
    // 两个标签
    @IBOutlet weak var distanceLabel: UILabel! // 当前标注数量
    @IBOutlet weak var amountLabel: UILabel! // 当前选中的标注与自己的距离
    
    // 当前选中的点到当前位置的距离
    var tmpCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var tmpDistance: Double = 0.0
    
    // 给CameraViewController传值，当前萌娘id
    var girlIdNow = 1
    
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
        self.view.sendSubview(toBack: mapView) // 置于底层
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
        // 添加标注
        for (_, annoMoeGirl) in girlAnnotations {
            addGirlAnnotation(annotation: annoMoeGirl)
        }
        // 标签文字
        amountLabel.text = "数量：\(girlAnnotations.count)"
    }
    
    // 在地图上添加大头针
    private func addGirlAnnotation(annotation: MoeGirlAnnotation) {
        let pMoeGirl = MAPointAnnotation() // 大头针标注
        pMoeGirl.coordinate.latitude = annotation.coordinate.latitude
        pMoeGirl.coordinate.longitude = annotation.coordinate.longitude
        pMoeGirl.title = annotation.girlName
        pMoeGirl.subtitle = annotation.girlDescription
        mapView.addAnnotation(pMoeGirl) // 显示标注
    }
    
    // 点击“返回”按钮
    //@IBAction func goBack(_ sender: UIButton) {
        // 回到主界面
    //    dismiss(animated: true, completion: nil)
    //}
    
    // 点击“刷新”按钮
    @IBAction func refresh(_ sender: UIButton) {
        // 清空数据和地图标注
        girlAnnotations.removeAll()
        CoreDataManager.shared.deleteAllAnnotations()
        if let mapAnnotationViews = mapView.annotations as? [MAAnnotation] {
            for anno in mapAnnotationViews {
                // 从地图移除该标注
                mapView.removeAnnotation(anno)
            }
        }
        // 刷新萌娘地图标注
        let annoNum = randomInt(min: MINAnnotationAmount, max: MAXAnnotationAmount)
        for _ in 1...annoNum {
            // 临时存储
            let annoMoeGirl = MoeGirlAnnotation()
            annoMoeGirl.setRandom() // 获取一个标注的随机值
            girlAnnotations[annoMoeGirl.annoId] = annoMoeGirl // 添加到地图标注字典
            // 持久存储
            CoreDataManager.shared.insertAnnotation(girlAnnotation: annoMoeGirl)
            // 添加标注
            addGirlAnnotation(annotation: annoMoeGirl)
        }
        // 标签文字
        amountLabel.text = "数量：\(girlAnnotations.count)"
    }
    
    // 每刷新用户位置
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if let tmpLocation = userLocation.location {
            myLocation = tmpLocation
            // 获取选中的点到当前位置的距离
            tmpDistance = MAMetersBetweenMapPoints(MAMapPointForCoordinate(myLocation.coordinate),
                                                   MAMapPointForCoordinate(tmpCoordinate))
            if tmpDistance < 1000000 {
                distanceLabel.text = String(format: "距离：%.1f m", tmpDistance)
            }
        }
    }
    
    // 比较两个MAAnnotation或CLLocation或MoeGirlAnnotation的地址
    private func hasEqualCoordinate(locCoordinate1: MAAnnotation?, locCoordinate2: MAAnnotation?) -> Bool {
        return (locCoordinate1?.coordinate.latitude == locCoordinate2?.coordinate.latitude &&
            locCoordinate1?.coordinate.longitude == locCoordinate2?.coordinate.longitude)
    }
    private func hasEqualCoordinate(locCoordinate1: MAAnnotation?, locCoordinate2: CLLocation?) -> Bool {
        return (locCoordinate1?.coordinate.latitude == locCoordinate2?.coordinate.latitude &&
            locCoordinate1?.coordinate.longitude == locCoordinate2?.coordinate.longitude)
    }
    private func hasEqualCoordinate(locCoordinate1: MAAnnotation?, locCoordinate2: MoeGirlAnnotation?) -> Bool {
        return (locCoordinate1?.coordinate.latitude == locCoordinate2?.coordinate.latitude &&
            locCoordinate1?.coordinate.longitude == locCoordinate2?.coordinate.longitude)
    }
    
    // 回调，标注样式
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        // 仅仅处理选中的，且不是当前位置的annotation，防止小蓝点被覆盖
        //if annotation.coordinate.latitude == myLocation?.coordinate.latitude &&
        //annotation.coordinate.longitude == myLocation?.coordinate.longitude {
        //    return nil
        //} // 此方法已经淘汰，因为可能由于用户位置刷新不及时导致不同步，使得小蓝点被覆盖
        if let mapAnnotationViews = mapView.annotations as? [MAAnnotation] {
            if mapAnnotationViews.contains(where: { (annoExceptMyLocation) -> Bool in
                return hasEqualCoordinate(locCoordinate1: annoExceptMyLocation, locCoordinate2: annotation) }) {
                let pointReuseIndetifier = "pointReuseIndetifier"
                var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
                if annotationView == nil {
                    annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
                }
                annotationView!.animatesDrop = true // 有下落动画
                annotationView!.isDraggable = false // 不可拖拽
                // 显示按钮；点击按钮才会进入AR界面
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
                // 标注大头针颜色：0红，1绿，2紫
                annotationView!.pinColor = MAPinAnnotationColor(rawValue: getGirlId(annotation: annotation) % 3)!
                return annotationView!
            }
        }
        return nil
    }
    
    // 每选中一个标注
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        if let pTmp = view.annotation {
            // 点击当前位置
            if hasEqualCoordinate(locCoordinate1: pTmp, locCoordinate2: myLocation) {
                print("Select my Location !")
                // 恢复旋转模式
                mapView.userTrackingMode = MAUserTrackingMode.followWithHeading
                distanceLabel.text = "距离：? m"
                return
            }
            // 点击萌娘出现的位置，自动计算距离
            tmpCoordinate.latitude = pTmp.coordinate.latitude
            tmpCoordinate.longitude = pTmp.coordinate.longitude
            tmpDistance = MAMetersBetweenMapPoints(MAMapPointForCoordinate(myLocation.coordinate),
                                                   MAMapPointForCoordinate(tmpCoordinate))
            distanceLabel.text = String(format: "距离：%.1f m", tmpDistance)
        }
    }
    
    // 每取消选中的标注
    func mapView(_ mapView: MAMapView!, didDeselect view: MAAnnotationView!) {
        distanceLabel.text = "距离：? m"
    }
    
    // 每点击一个标注
    func mapView(_ mapView: MAMapView!, didAnnotationViewTapped view: MAAnnotationView!) {
    }
    
    // 获取当前萌娘类型Id
    private func getGirlId(annotation: MAAnnotation?) -> Int {
        for (_, girlAnno) in girlAnnotations {
            if hasEqualCoordinate(locCoordinate1: annotation, locCoordinate2: girlAnno) {
                // 得到当前标注
                return girlAnno.girlId
            }
        }
        return 1
    }
    
    // 获取当前萌娘标注Id
    private func getAnnotationId(annotation: MAAnnotation?) -> Int {
        for (_, girlAnno) in girlAnnotations {
            if hasEqualCoordinate(locCoordinate1: annotation, locCoordinate2: girlAnno) {
                // 得到当前标注
                return girlAnno.annoId
            }
        }
        return 0
    }
    
    // 当点击标注的按钮时
    func mapView(_ mapView: MAMapView!, annotationView view: MAAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let pTmp = view.annotation {
            if hasEqualCoordinate(locCoordinate1: pTmp, locCoordinate2: myLocation) {
                return // 点击用户当前位置，直接返回
            }
            // 点击萌娘出现的位置
            if MAMetersBetweenMapPoints(MAMapPointForCoordinate(pTmp.coordinate),
                                        MAMapPointForCoordinate(myLocation.coordinate))
                <= catchRange { // 在最小捕捉范围之内
                // 获取当前萌娘类型
                girlIdNow = getGirlId(annotation: pTmp)
                print(girlIdNow)
                // 从存储数据中移除该标注
                let annoIdNow = getAnnotationId(annotation: pTmp)
                print(annoIdNow)
                print(Int32(annoIdNow))
                girlAnnotations.removeValue(forKey: annoIdNow)
                CoreDataManager.shared.deleteAnnotationById(id: annoIdNow)
                // 从地图移除该标注
                mapView.removeAnnotation(pTmp)
                // 标签文字
                amountLabel.text = "数量：\(girlAnnotations.count)"
                // 加载摄像头视图
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let ARViewController = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
                ARViewController.girlIdNow = girlIdNow // 传值
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
