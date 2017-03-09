//
//  TwitterViewController.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/18.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit

class TwitterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let loginButton = TWTRLogInButton(logInCompletion: {
            session, error in
            if session != nil {
                print(session?.userName ?? "noname")
                // ログイン成功したら遷移する
                let timelineVC = TimelineViewController()
                UIApplication.shared.keyWindow?.rootViewController = timelineVC
            } else {
                print(error?.localizedDescription ?? "noname")
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
