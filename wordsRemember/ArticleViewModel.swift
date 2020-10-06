//
//  ArticleViewModel.swift
//  wordsRemember
//
//  Created by liuhongnian on 2020/10/2.
//  Copyright © 2020 liuhongnian. All rights reserved.
//

import UIKit

class ArticleViewModel: NSObject {
    
    @objc dynamic var article: Dictionary<String, Any> = [:]
    
    @objc dynamic var error: NSError?
    
    @objc func todayArticle()  {
        
           /* Configure session, choose between:
              * defaultSessionConfiguration
              * ephemeralSessionConfiguration
              * backgroundSessionConfigurationWithIdentifier:
            And set session-wide properties, such as: HTTPAdditionalHeaders,
            HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
            */
           let sessionConfig = URLSessionConfiguration.default

           /* Create session, and optionally set a URLSessionDelegate. */
           let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

           /* Create the Request:
              岛读每日书单 (GET https://rike-api.moreless.io/v1/lessons)
            */

           guard var URL = URL(string: "https://rike-api.moreless.io/v1/lessons") else {return}
        

        let dateComponent = NSCalendar.current.dateComponents([.year,.month,.day], from: NSDate.init() as Date)
        let from = String.init(format: "%d-%02d-%02d", dateComponent.year!, dateComponent.month!, dateComponent.day!)
        let to = from
        let URLParams = [
               "from": from,
               "to": to,
           ]
           URL = URL.appendingQueryParameters(URLParams)
           var request = URLRequest(url: URL)
           request.httpMethod = "GET"

           // Headers

//           request.addValue("tgw_l7_route=cbc963a4bdf805507c2289b3e8e93a6b", forHTTPHeaderField: "Cookie")

           /* Start a new Task */
           let task = session.dataTask(with: request, completionHandler: {[weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
               if (error == nil) {
                   // Success
                   let statusCode = (response as! HTTPURLResponse).statusCode
                   print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                guard let responseJson = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
                    self?.error = NSError.init(domain: "服务器异常，请稍后再试", code: 1, userInfo: nil)
                    return
                }
                
                if responseJson is Array<Dictionary<String, Any>> {
                    let array = responseJson as! Array<Dictionary<String, Any>>
                    let article = array.first    
                    self?.article = article ?? [:]

                }else{
                    
                    self?.error = NSError.init(domain: "服务器异常，请稍后再试", code: 1, userInfo: nil)

                }
                
                
               }
               else {
                   // Failure
                   print("URL Session Task Failed: %@", error!.localizedDescription);
                self?.error = NSError.init(domain: error!.localizedDescription, code: 1, userInfo: nil)
               }
           })
           task.resume()
           session.finishTasksAndInvalidate()
       }

}
