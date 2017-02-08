//
//  LoadFile.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/08.
//  Copyright © 2017年 kengo. All rights reserved.
//

import Foundation

class LoadFile: NSObject {
    //CSVファイル読み込みメソッド。引数でファイル名を取得。戻り値はString型の配列。
    func loadCSV(_ fileName :String) -> [String]{
        //CSVファイルのデータを格納するStrig型配列
        var csvArray:[String] = []
        //引数filnameからCSVファイルのパスを設定
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            //csvBundleからファイルを読み込み、エンコーディングしてcsvDataに格納
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            //改行コードが"\r"の場合は"\n"に置換する
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            //"\n"の改行コードで要素を切り分け、配列csvArrayに格納する
            csvArray = lineChange.components(separatedBy: "\n")
        }catch{
            print("エラー")
        }
        return csvArray     //戻り値の配列csvArray
    }
}
