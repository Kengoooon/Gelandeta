//
//  ViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/08.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    //ゲレンデ配列
    var csvGelandeArray:[String] = []
    var gelandeArray:[String] = []
    var areaCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CSVファイルからゲレンデデータを読み込み
        let loadFile = LoadFile()
        csvGelandeArray = loadFile.loadCSV("gelande")
        print(csvGelandeArray)
        
        //とりあえず苗場を格納
        gelandeArray = csvGelandeArray[areaCount].components(separatedBy: ",")
        print(gelandeArray)
        // とりあえず地図を表示
        let camera = GMSCameraPosition.camera(withLatitude: 35.67,longitude: 139.74, zoom: 8)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        let marker2 = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(35.67, 139.74)
        marker2.position = CLLocationCoordinate2DMake(Double(gelandeArray[3])!, Double(gelandeArray[4])!)
        //marker.title = "SannoParkTower"
        //marker.snippet = "Japan"
        marker.map = mapView
        marker2.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

