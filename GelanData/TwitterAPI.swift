//
//  TwitterAPI.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/19.
//  Copyright © 2017年 kengo. All rights reserved.
//
import Foundation
import TwitterKit

class TwitterAPI {
    let baseURL = "https://api.twitter.com"
    let version = "/1.1"
    
    init() {
        
    }
    
    class func getHomeTimeline(tweets: @escaping ([TWTRTweet])->(), error: (NSError) -> ()) {
        let api = TwitterAPI()
        var clientError: NSError?
        let path = "/statuses/home_timeline.json"
        let endpoint = api.baseURL + api.version + path
        let client = TWTRAPIClient()
        //let request = Twitter.sharedInstance().client.URLRequestWithMethod("GET", URL: endpoint, parameters: nil, error: &clientError)
        let request = client.urlRequest(withMethod: "GET", url: endpoint, parameters: nil, error: &clientError)
        
        if request != nil {
            client.sendTwitterRequest(request, completion: {
                response, data, err in
                if err == nil {
                    var jsonError: NSError?
                    //let json: AnyObject? = JSONSerialization.JSONObjectWithData(data,options: nil, error: &jsonError)
                    //let json = JSONSerialization.JSONObjectWithData(data, options: nil, error: jsonError)
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                        
                        if json.object(forKey: "item") != nil {
                                if let jsonArray = json as? NSArray {
                                    tweets(TWTRTweet.tweets(withJSONArray: jsonArray as? [Any]) as! [TWTRTweet])
                                }
                        }
                        
                    } catch {
                        // エラー
                    }
                } else {
                    print("error")
                }
            })
        }
    }
}
