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

//クラス間で共有する変数
struct gelandeConditions{
    var course: String = ""
    var nighter: String = ""
    var begginer: String = ""
    var middle: String = ""
    var hard: String = ""
    var liftchicket: String = ""
}

    class searchgelandeViewController:UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate,UITabBarDelegate{

        var data = gelandeConditions()
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        @IBAction func gelanderesultButton(_ sender: UIButton) {
            performSegue(withIdentifier: "PushResult", sender: gelanderesultButton)
        }
        
        @IBAction func begineerButton(_ sender: UIButton) {
            data.begginer = "1"
        }
        
        @IBAction func middleButton(_ sender: UIButton) {
        }
        
        @IBAction func advancedButton(_ sender: UIButton) {
        }
        @IBAction func courseSegments(_ sender: UISegmentedControl) {
        }
        @IBAction func liftFeeSlider(_ sender: UISlider) {
        }
        @IBAction func nighterButton(_ sender: UIButton) {
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
}

