//
//  ViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/08.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate{
    
    //ゲレンデ配列
    var csvGelandeArray:[String] = []
    var gelandeArray:[String] = []
    var areaCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CSVファイルからゲレンデデータを読み込み
        let loadFile = LoadFile()
        csvGelandeArray = loadFile.loadCSV("gelande")
        
        // とりあえず地図を表示
        var camera = GMSCameraPosition.camera(withLatitude: 35.67,longitude: 139.74, zoom: 8)
        var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        self.view = mapView
        
        
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
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker){
        // ユーザーに関わる処理
        print("タップイベント")
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

