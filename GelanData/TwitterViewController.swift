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
                print(session?.userName)
                // ログイン成功したらクソ遷移する
                let timelineVC = TWTRTimelineViewController()
                UIApplication.shared.keyWindow?.rootViewController = timelineVC
            } else {
                print(error?.localizedDescription)
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
