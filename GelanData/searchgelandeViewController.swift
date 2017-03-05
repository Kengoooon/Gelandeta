//
//  searchgelandeViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/03/04.
//  Copyright © 2017年 kengo. All rights reserved.
//
import UIKit
import GoogleMaps
import CoreLocation
import Foundation

    class searchgelandeViewController:UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate,UITabBarDelegate{
        //ゲレンデ配列
        var csvGelandeArray:[String] = []
        var gelandeArray:[String] = []
        var areaCount:Int = 0
        // 現在地の位置情報の取得にはCLLocationManagerを使用
        var locationManager: CLLocationManager!
        // 取得した緯度を保持するインスタンス
        var latitude: CLLocationDegrees!
        // 取得した経度を保持するインスタンス
        var longitude: CLLocationDegrees!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
        
        @IBAction func gelanderesultButton(_ sender: UIButton) {
            // とりあえず地図を表示
            let camera = GMSCameraPosition.camera(withLatitude: 35.67,longitude: 139.74, zoom: 8)
            //var camera = GMSCameraPosition.camera(withLatitude: latitude,longitude: longitude, zoom: 8)
            
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            mapView.isMyLocationEnabled = true
            mapView.delegate = self
            mapView.frame = self.view.bounds
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.insertSubview(mapView,at:0)
            
            if CLLocationManager.locationServicesEnabled() {
                print("GPS発動！！！")
                // 位置情報フィールドの初期化
                locationManager = CLLocationManager()
                longitude = CLLocationDegrees()
                latitude = CLLocationDegrees()
                // CLLocationManagerをDelegateに指定
                locationManager.delegate = self
                // 位置情報取得の許可を求めるメッセージの表示．必須．
                locationManager.requestAlwaysAuthorization()
                // 位置情報の精度を指定．任意，
                // lm.desiredAccuracy = kCLLocationAccuracyBest
                // 位置情報取得間隔を指定．指定した値（メートル）移動したら位置情報を更新する．任意．
                locationManager.distanceFilter = 10
                // GPSの使用を開始する
                locationManager.startUpdatingLocation()
                
            }


            
        }
        
        
        func mapView(_ mapView: GMSMapView, didTapInfoWindowOf didTapInfoWindowOfMarker: GMSMarker){
            // ユーザーに関わる処理
            print("タップイベント")
            
            
        }
        func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf : GMSMarker){
            // ユーザーに関わる処理
            print("ロングタップイベント")
            //snipperの値を改行区切りで配列に格納
            var courseArray:[String] = String(didLongPressInfoWindowOf.snippet!).components(separatedBy: "\n")
            let url = NSURL(string: courseArray[0])
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
            } else {
                if UIApplication.shared.canOpenURL(url! as URL){
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            
        }
        
        
        //ユーザが位置情報の使用を許可しているか確認
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                break
            case .authorizedAlways, .authorizedWhenInUse:
                break
            }
        }
        
        // 位置情報が更新されるたびに呼ばれる
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard locations.last != nil else {
                print("更新")
                return
            }
        }
        
        func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
            // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
            latitude = newLocation.coordinate.latitude
            // 取得した経度がnewLocation.coordinate.longitudeに格納されている
            longitude = newLocation.coordinate.longitude
            // 取得した緯度・経度をLogに表示
            print("自分latiitude: \(latitude) , longitude: \(longitude)")
            
            // GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
            // lm.stopUpdatingLocation()
        }
        
        /* 位置情報取得失敗時に実行される関数 */
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            // この例ではLogにErrorと表示するだけ．
            NSLog("ErrorErrorErrorErrorError")
        }
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
}

