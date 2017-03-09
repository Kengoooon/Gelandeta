//
//  SnowboardViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/22.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import CoreLocation

class SnowboardViewController: UIViewController,CLLocationManagerDelegate{
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var getLocationButton: UIButton!
    @IBOutlet weak var latitudeLabelEnd: UILabel!
    @IBOutlet weak var longitudeLabelEnd: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var totalrunsLabel: UILabel!
    @IBOutlet weak var totalcaloriesLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
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
        
        //グラデーションの設定
        let gradientLayer = CAGradientLayer()
        //フレームを用意
        gradientLayer.frame = backgroundView.bounds
        //色を定義
        let color1 = UIColor(red: 0.4, green: 0.7, blue: 0.9, alpha: 1.0).cgColor as CGColor
        let color2 = UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0).cgColor as CGColor
        let color3 = UIColor.white.cgColor
        //グラデーションレイヤーに色を設定
        gradientLayer.colors = [color1, color2,color3]
        //始点・終点の設定
        gradientLayer.startPoint = CGPoint(x:0,y:0);
        gradientLayer.endPoint = CGPoint(x:1.0,y:0.8);
        //headerviewにグラデーションレイヤーを挿入
        backgroundView.layer.insertSublayer(gradientLayer,at:0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            print(buttonCount)
            if (buttonCount % 2) != 0{
                print("奇数")
                latitudeLabel.text = "緯度：\(location.coordinate.latitude)"
                longitudeLabel.text = "経度：\(location.coordinate.longitude)"
                preLocation = location
            }
            else if (buttonCount % 2) == 0{
                print("偶数")
                latitudeLabelEnd.text = "緯度：\(location.coordinate.latitude)"
                longitudeLabelEnd.text = "経度：\(location.coordinate.longitude)"
                endLocation = location
            }
            if (buttonCount % 2) == 0 && preLocation != nil && endLocation != nil{
                let result:Double = endLocation!.distance(from: preLocation!)
                resultLabel.text = String(format: "%.2f m",result)
                totalrunsLabel.text = String(buttonCount / 2)
                totalcaloriesLabel.text = String(format: "%.2f ",result / 5000 * 300)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    @IBAction func onClickGetLocationButton(_ sender: UIButton) {
        buttonCount += 1
        myLocationManager.requestLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
