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
        //#ゲレンデのツイートをタイムラインで表示
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "#ゲレンデ", apiClient: client)
    }
    
}
