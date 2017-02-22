//
//  MapViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/19.
//  Copyright © 2017年 kengo. All rights reserved.
//
//
//  ViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/08.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate,UITabBarDelegate{
    
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
        
        //CSVファイルからゲレンデデータを読み込み
        let loadFile = LoadFile()
        csvGelandeArray = loadFile.loadCSV("gelande")
        
        // とりあえず地図を表示
        var camera = GMSCameraPosition.camera(withLatitude: 35.67,longitude: 139.74, zoom: 8)
        //var camera = GMSCameraPosition.camera(withLatitude: latitude,longitude: longitude, zoom: 8)
        
        var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        self.view = mapView
        
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
        
        //ゲレンデデータの読み込み関数
        func nextGerande(){
            gelandeArray.removeAll()
            gelandeArray = csvGelandeArray[areaCount].components(separatedBy: ",")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(Double(gelandeArray[3])!, Double(gelandeArray[4])!)
            marker.title = String(gelandeArray[1])!
            marker.snippet = String(gelandeArray[5])!
            marker.map = mapView
            areaCount += 1
        }
        
        for _ in 0..<csvGelandeArray.count - 1{
            nextGerande()
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
        
        //  self.latTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.latitude)
        //   self.lngTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.longitude)
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
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf didTapInfoWindowOfMarker: GMSMarker){
        // ユーザーに関わる処理
        print("タップイベント")
        let url = NSURL(string: String(gelandeArray[5])!)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
        } else {
            if UIApplication.shared.canOpenURL(url! as URL){
                UIApplication.shared.openURL(url! as URL)
            }
        }
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

