//
//  WordViewModel.swift
//  wordsRemember
//
//  Created by liuhongnian on 2020/10/1.
//  Copyright © 2020 liuhongnian. All rights reserved.
//

import UIKit

@objc class WordViewModel: NSObject {
    
    @objc dynamic var wordResult: Dictionary<String, Any> = [:]
    @objc dynamic var error: NSError?
    
    
        @objc func goldenWords() {
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
               Request (2) (GET https://v1.hitokoto.cn/)
             */

            guard var URL = URL(string: "https://v1.hitokoto.cn/") else {return}
            let URLParams = [
                "c": "d",
                "encode": "json",
            ]
            URL = URL.appendingQueryParameters(URLParams)
            var request = URLRequest(url: URL)
            request.httpMethod = "GET"

            /* Start a new Task */
            let task = session.dataTask(with: request, completionHandler: {[weak self] (data: Data?, response: URLResponse?, requestError: Error?) -> Void in
                if (requestError == nil) {
                    // Success
//                    let statusCode = (response as! HTTPURLResponse).statusCode
                    
                        guard let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
                            print("invalid json data")

                            self?.error = NSError.init(domain: "服务器异常，请稍后再试", code: 1, userInfo: nil);
                            return
                        }
                        
                        self?.wordResult = jsonObject as! Dictionary
                        
                } else {
                    // Failure
                    self?.error = NSError.init(domain: requestError!.localizedDescription, code: 1, userInfo: nil)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
        }

}


protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
    */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    /**
     Creates a new URL by adding the given query parameters.
     @param parametersDictionary The query parameter dictionary to add.
     @return A new URL.
    */
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
