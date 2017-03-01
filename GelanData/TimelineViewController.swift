//
//  TimelineViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/19.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import TwitterKit

class TimelineViewController: TWTRTimelineViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タイトルの表示
        self.navigationItem.title = "ゲレンデツイート！"
        let client = TWTRAPIClient()
        
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                // ユーザ名からタイムラインを取得
                //self.dataSource = TWTRUserTimelineDataSource(screenName: session!.userName, apiClient: client)
            } else {
                print("error: \(error!.localizedDescription)")
            }
        }
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "#スキー場", apiClient: client)

    }
    
}
