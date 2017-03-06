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
    var gelandeArray2:[String] = []
    var areaCount:Int = 0
    var gelandeCount:Int = 0
    
    //クラス間で共有する関数をインスタンス化
    var data = gelandeConditions()

    // ステータスバーの高さ
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(data)
        print("bigginer\(data.begginer)")
        data.begginer = "1"
        
        
        //CSVファイルからゲレンデデータを読み込み
        let loadFile = LoadFile()
        csvGelandeArray = loadFile.loadCSV("gelande")
        
        for _ in 0..<csvGelandeArray.count - 1{
            gelandeArray2 = csvGelandeArray[areaCount].components(separatedBy: ",")
            
            if data.begginer == "1"{
                print(gelandeArray2[7])
                if Int(gelandeArray2[7])! > 30{
                    gelandeCount += 1
                    print(gelandeArray2[7])
                }
            }
            areaCount += 1
            gelandeArray2.removeAll()
        }
        gelandeArray2.removeAll()
        areaCount = 0
        
        print("カウント\(gelandeCount)")
        
        
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
    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //ゲレンデデータの読み込み関数
        func nextGerande(){
            gelandeArray.removeAll()
            gelandeArray = csvGelandeArray[areaCount].components(separatedBy: ",")
        }
        
        nextGerande()
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .detailButton
        cell.textLabel?.text = "\(gelandeArray[1])"
        cell.detailTextLabel?.text = "\(gelandeArray[5])"
        areaCount += 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数を設定
        return (csvGelandeArray.count - 1)
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
        let cell = tableView.cellForRow(at: indexPath)!
        let url = NSURL(string: (cell.detailTextLabel?.text)!)
        print(gelandeArray[5])
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
        } else {
            if UIApplication.shared.canOpenURL(url! as URL){
                UIApplication.shared.openURL(url! as URL)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    


}
