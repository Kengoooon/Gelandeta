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
    @IBOutlet var backgroundView: UIView!
    //ゲレンデ配列
    var csvGelandeArray:[String] = []
    var gelandeArray:[String] = []
    var gelandenameArray:[String] = []
    var gelandeAddress:[String] = []
    var gelandeHpArray:[String] = []
    var gelandeBeginner:[String] = []
    var gelandeMiddle:[String] = []
    var gelandeHard:[String] = []
    var gelandeCourse:[String] = []
    var gelandeLiftfee:[String] = []
    var gelandeNighter:[String] = []
    var gelandeArea:[String] = []
    var areaCount:Int = 0
    var gelandeCount:Int = 0
    //クラス間で共有する関数をインスタンス化
    var data = gelandeConditions()
    //セクション名を格納
    var sections = [String]()
    
    // ステータスバーの高さ
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //CSVファイルからゲレンデデータを読み込み
        let loadFile = LoadFile()
        csvGelandeArray = loadFile.loadCSV("gelande")
        
        //リスト表示するゲレンデ数を算出
        for _ in 0..<csvGelandeArray.count - 1{
            gelandeArray = csvGelandeArray[areaCount].components(separatedBy: ",")

            //初心者ゲレンデかつナイターありかつ長野の場合
            if data.begginer == 1 && data.nighter == 1 && data.area == "Nagano"{
                if Int(gelandeArray[7])! > 40 && Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("初心者ゲレンデかつナイターありかつ長野の場合")
                }
            }
            //初心者ゲレンデかつナイターなしかつ長野の場合
            else if data.begginer == 1 && data.nighter == 0 && data.area == "Nagano"{
                if Int(gelandeArray[7])! > 40 && Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("初心者ゲレンデかつナイターなしかつ長野の場合")
                }
            }
            //初心者ゲレンデかつナイターなしかつ長野の場合
            else if data.begginer == 1 && data.nighter == 0 && data.area == "Gunma"{
                if Int(gelandeArray[7])! > 40 && Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "群馬"{
                    gelandeCalc()
                    print("初心者ゲレンデかつナイターなしかつ長野の場合")
                }
            }
            //初心者ゲレンデかつナイターありかつ新潟の場合
            else if data.begginer == 1 && data.nighter == 1 && data.area == "Nigata"{
                if Int(gelandeArray[7])! > 40 && Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("初心者ゲレンデかつナイターありかつ新潟の場合")
                }
            }
            //初心者ゲレンデかつナイターなしかつ新潟の場合
            else if data.begginer == 1 && data.nighter == 0 && data.area == "Nigata"{
                if Int(gelandeArray[7])! > 40 && Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("初心者ゲレンデかつナイターなしかつ新潟の場合")
                }
            //中級者ゲレンデかつナイターありかつ長野の場合
            }else if data.middle == 1 && data.nighter == 1 && data.area == "Nagano"{
                if Int(gelandeArray[8])! > 40 && Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course &&  gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("中級者ゲレンデかつナイターありかつ長野の場合")
                }
            //中級者ゲレンデかつナイターなしかつ長野の場合
            }else if data.middle == 1 && data.nighter == 0 && data.area == "Nagano"{
                if Int(gelandeArray[8])! > 40 && Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("中級者ゲレンデかつナイターなしかつ長野の場合")
                }
            //中級者ゲレンデかつナイターありかつ新潟の場合
            }else if data.middle == 1 && data.nighter == 1 && data.area == "Nigata"{
                if Int(gelandeArray[8])! > 40 && Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("中級者ゲレンデかつナイターありかつ新潟の場合")
                }
            //中級者ゲレンデかつナイターなしかつ新潟の場合
            }else if data.middle == 1 && data.nighter == 0 && data.area == "Nigata"{
                if Int(gelandeArray[8])! > 40 && Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("中級者ゲレンデかつナイターなしかつ新潟の場合")
                }
            //上級者ゲレンデかつナイターありかつ長野の場合
            }else if data.hard == 1 && data.nighter == 1 && data.area == "Nagano"{
                if Int(gelandeArray[9])! > 30 && Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("上級者ゲレンデかつナイターありかつ長野の場合")
                }
            //上級者ゲレンデかつナイターなしかつ長野の場合
            }else if data.hard == 1 && data.nighter == 0 && data.area == "Nagano"{
                if Int(gelandeArray[9])! > 30 && Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("上級者ゲレンデかつナイターなしかつ長野の場合")
                }
            //上級者ゲレンデかつナイターありかつ新潟の場合
            }else if data.hard == 1 && data.nighter == 1 && data.area == "Nigata"{
                if Int(gelandeArray[9])! > 30 && Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("上級者ゲレンデかつナイターありかつ新潟の場合")
                }
            //上級者ゲレンデかつナイターなしかつ新潟の場合
            }else if data.hard == 1 && data.nighter == 0 && data.area == "Nigata"{
                if Int(gelandeArray[9])! > 30 && Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course &&  gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("上級者ゲレンデかつナイターなしかつ新潟の場合")
                }
            //ナイターあり長野の場合
            }else if data.nighter == 1 && data.area == "Nagano"{
                if Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("ナイターあり長野の場合")
                }
            //ナイターあり新潟の場合
            }else if data.nighter == 1 && data.area == "Nigata"{
                if Int(gelandeArray[10])! == 1 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("新潟")
                    print("ナイターあり新潟の場合")
                }
            //ナイターなし長野の場合
            }else if data.nighter == 0 && data.area == "Nagano"{
                if Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "長野"{
                    gelandeCalc()
                    print("ナイターなし長野の場合")
                }
            //ナイターなし新潟の場合
            }else if data.nighter == 0 && data.area == "Nigata"{
                if Int(gelandeArray[10])! == 0 && Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course && gelandeArray[12] == "新潟"{
                    gelandeCalc()
                    print("ナイターなし新潟の場合")
                }
            }else{
                if Double(gelandeArray[11])! <= data.liftchicket && Int(gelandeArray[6])! >= data.course{
                    gelandeCalc()
                    print("えls")
                }
            }
            //print(data)
            print(gelandeArray)
            areaCount += 1
            gelandeArray.removeAll()
        }
        gelandeArray.removeAll()
        areaCount = 0
        print(gelandeCount)
        print("name\(gelandenameArray)")
 
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
        
        let tableView = UITableView()
        // サイズと位置調整
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight + 20,
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
    
    //条件に応じた配列を作成
    func gelandeCalc(){
        gelandeCount += 1
        gelandenameArray.append(gelandeArray[1])
        gelandeAddress.append(gelandeArray[2])
        gelandeHpArray.append(gelandeArray[5])
        gelandeCourse.append(gelandeArray[6])
        gelandeBeginner.append(gelandeArray[7])
        gelandeMiddle.append(gelandeArray[8])
        gelandeHard.append(gelandeArray[9])
        gelandeNighter.append(gelandeArray[10])
        gelandeLiftfee.append(gelandeArray[11])
        gelandeArea.append(gelandeArray[12])
    }
    
    // セルを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ゲレンデデータの読み込み関数
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .detailButton
        cell.textLabel?.text = "\(gelandenameArray[indexPath.row])"
        cell.detailTextLabel?.text = "\(gelandeHpArray[indexPath.row])"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数を設定
        return (gelandeCount)
    }
    
    //UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルがタップされた時の処理
        print("タップされたセルのindex番号: \(indexPath.row)")
        // アラート表示
        let alert: UIAlertController = UIAlertController(title: "\(gelandenameArray[indexPath.row])", message: "コース数:\(gelandeCourse[indexPath.row])                                                 初級:\(gelandeBeginner[indexPath.row])%,中級:\(gelandeMiddle[indexPath.row])%,上級:\(gelandeHard[indexPath.row])%", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        } else {
            if UIApplication.shared.canOpenURL(url! as URL){
                UIApplication.shared.openURL(url! as URL)
            }
        }
    }
    
    //セクションの設定を行う
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.white
        if(section == 0){
            label.text = sections[section]
        } else if (section == 1){
            label.text = sections[section]
        }
        return label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    


}
