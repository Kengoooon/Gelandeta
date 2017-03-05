//
//  MapResultViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/03/05.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Foundation

class MapResultViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //ゲレンデ配列
    var csvGelandeArray:[String] = []
    var gelandeArray:[String] = []
    var areaCount:Int = 0
    
    //クラス間で共有する関数をインスタンス化
    var data = gelandeConditions()
    // ステータスバーの高さ
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CSVファイルからゲレンデデータを読み込み
        let loadFile = LoadFile()
        csvGelandeArray = loadFile.loadCSV("gelande")
        
        //ゲレンデデータの読み込み関数
        func nextGerande(){
            gelandeArray.removeAll()
            gelandeArray = csvGelandeArray[areaCount].components(separatedBy: ",")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(Double(gelandeArray[3])!, Double(gelandeArray[4])!)
            marker.title = String(gelandeArray[1])!
            marker.snippet = String(String(gelandeArray[5])! + "\n" + String(gelandeArray[6])! + "\n" + String(gelandeArray[7])! + "\n" + String(gelandeArray[8])! + "\n" + String(gelandeArray[9])! + "\n" + String(gelandeArray[10])!)
            areaCount += 1
            
            if data.begginer == "1"{
                gelandeArray.removeAll()
                gelandeArray = csvGelandeArray[areaCount].components(separatedBy: ",")
                if Int(gelandeArray[6])! > 30 {
                    
                }
                
            }
            
        }
        for _ in 0..<csvGelandeArray.count - 1{
            nextGerande()
        }
        
        let tableView = UITableView()
        // サイズと位置調整
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight
        )
        
        // Delegate設定
        tableView.delegate = self
        
        // DataSource設定
        tableView.dataSource = self
        
        // 画面に UITableView を追加
        self.view.addSubview(tableView)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作る
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .detailButton
        cell.textLabel?.text = "セル\(indexPath.row + 1)"
        cell.detailTextLabel?.text = "\(indexPath.row + 1)番目のセルの説明"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数を設定
        return 5
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルがタップされた時の処理
        print("タップされたセルのindex番号: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 64
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // アクセサリボタン（セルの右にあるボタン）がタップされた時の処理
        print("タップされたアクセサリがあるセルのindex番号: \(indexPath.row)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    


}
