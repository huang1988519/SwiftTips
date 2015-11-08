//
//  Network.swift
//  SwiftTips
//
//  Created by hwh on 15/11/6.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit
import Alamofire

struct UrlConfig {
    static let baseUrl = "http://swifter.tips/"
    
    func indexUrlForPage(page:Int) ->String{
        return UrlConfig.baseUrl+"page/\(page)"
    }
}
extension Request {
    var tag: String {
        if let req = self.request {
            return req.URLString
        }
        return ""
    }
}
class Network: NSObject {
    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    var page = 1//从page 1开始
    
    var resultData = NSData()
    var _completedHandle : ((NSData) ->Void)?
    func start() -> Network{
        let url = UrlConfig().indexUrlForPage(page)
        
        Alamofire
            .request(.GET, url)
            .response { (request, response, data, error) -> Void in
                if response?.statusCode == 200 {
                    debugPrint("请求成功")
                    Cache().storeFile(request!.URLString, data: data)
                    self.resultData = data!
                    
                    self._completedHandle!(data!)
                }else{
                    debugPrint("!!请求失败!!")
                }
        }
        return self
    }
    func response(completedHandle: (NSData) -> Void) -> Network {
        _completedHandle = completedHandle
        return self
    }
}


