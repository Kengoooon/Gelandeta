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
    var course: String = "1"
    var nighter: String = ""
    var begginer: String = ""
    var middle: String = ""
    var hard: String = ""
    var liftchicket: String = "5000"
    var area:String = ""
}

    class searchgelandeViewController:UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate,UITabBarDelegate{
        @IBOutlet weak var begginerButton: UIButton!
        @IBOutlet weak var middleButton: UIButton!
        @IBOutlet weak var hardButton: UIButton!
        @IBOutlet weak var nighterButton: UIButton!
        @IBOutlet weak var liftfeeLabel: UILabel!
        @IBOutlet var backgroundView: UIView!
        @IBOutlet weak var areaNagano: UIButton!
        @IBOutlet weak var areaNigata: UIButton!

        var data = gelandeConditions()
        var count:Int = 0
        
        @IBAction func back(segue:UIStoryboardSegue){
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            buttonReset()
            areaReset()
            self.nighterButton.backgroundColor = UIColor.gray
            
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
        func buttonReset(){
            self.begginerButton.backgroundColor = UIColor.gray
            self.middleButton.backgroundColor = UIColor.gray
            self.hardButton.backgroundColor = UIColor.gray
        }
        
        func areaReset(){
            self.areaNagano.backgroundColor = UIColor.gray
            self.areaNigata.backgroundColor = UIColor.gray
        }
        
        //初心者ボタン
        @IBAction func begineerButton(_ sender: UIButton) {
            data.begginer = "1"
            data.middle = "0"
            data.hard = "0"
            buttonReset()
            self.begginerButton.backgroundColor = UIColor.blue
        }
        
        //中級者ボタン
        @IBAction func middleButton(_ sender: UIButton) {
            data.begginer = "0"
            data.middle = "1"
            data.hard = "0"
            buttonReset()
            self.middleButton.backgroundColor = UIColor.blue
        }
        
        //上級者ボタン
        @IBAction func advancedButton(_ sender: UIButton) {
            data.begginer = "0"
            data.middle = "0"
            data.hard = "1"
            buttonReset()
            self.hardButton.backgroundColor = UIColor.blue
        }
        
        //コース数を選択
        @IBAction func courseSegments(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0:
                data.course = "1"
            case 1:
                data.course = "5"
            case 2:
                data.course = "10"
            case 3:
                data.course = "15"
            default:break
            }
        }
        
        //リフト券代金を選択
        @IBAction func liftFeeSlider(_ sender: UISlider) {
            liftfeeLabel.text = "¥\(String(Int(sender.value)))以下"
            data.liftchicket = String(round(sender.value))
        }
        
        //ナイターを選択
        @IBAction func nighterButton(_ sender: UIButton) {
            data.nighter = "1"
            if count == 0{
            self.nighterButton.backgroundColor = UIColor.blue
                count = 1
            }else{
            self.nighterButton.backgroundColor = UIColor.gray
                count = 0
            }
        }

        @IBAction func areaNigataButton(_ sender: UIButton) {
            areaReset()
            data.area = "Nigata"
            self.areaNigata.backgroundColor = UIColor.blue
        }
        @IBAction func areaNaganoButton(_ sender: UIButton) {
            areaReset()
            data.area = "Nagano"
            self.areaNagano.backgroundColor = UIColor.blue
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            if let destinationViewController = segue.destination as? MapResultViewController{
                destinationViewController.data = data
            }
        }
        
        
        
}

