//
//  SnowboardViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/22.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import CoreLocation

//let 現在地の緯度: Double = 135.5258549
//let 現在地の経度: Double = 34.6873527
//let 行き先の緯度: Double = 139.75313186645508
//let 行き先の経度: Double = 35.68525668970075
//let 現在地の位置情報: CLLocation = CLLocation(latitude: 現在地の緯度, longitude: 現在地の経度)
//let 行き先の位置情報: CLLocation = CLLocation(latitude: 行き先の緯度, longitude: 行き先の経度)
//距離 = 行き先の位置情報.distanceFromLocation(現在地の位置情報)


class SnowboardViewController: UIViewController,CLLocationManagerDelegate{
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var getLocationButton: UIButton!
    @IBOutlet weak var latitudeLabelEnd: UILabel!
    @IBOutlet weak var longitudeLabelEnd: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var myLocationManager: CLLocationManager!
    var myLocationManager2: CLLocationManager!
    var buttonCount:Int = 0
    var preLocation: CLLocation?
    var endLocation: CLLocation?
    var stockLati: String = ""
    var stockLong: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied {
            return
        }
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self

        if status == CLAuthorizationStatus.notDetermined {
            myLocationManager.requestWhenInUseAuthorization()
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            if (buttonCount / 2) != 1{
                latitudeLabel.text = "緯度：\(location.coordinate.latitude)"
                longitudeLabel.text = "経度：\(location.coordinate.longitude)"
                preLocation = location
            }else{
                latitudeLabelEnd.text = "緯度：\(location.coordinate.latitude)"
                longitudeLabelEnd.text = "経度：\(location.coordinate.longitude)"
                endLocation = location
            }
            if (buttonCount/2) == 1 && preLocation != nil && endLocation != nil{
                let result:Double = endLocation!.distance(from: preLocation!)
                resultLabel.text = String(result) + "m"
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    @IBAction func onClickGetLocationButton(_ sender: UIButton) {
        myLocationManager.requestLocation()
        buttonCount += 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
