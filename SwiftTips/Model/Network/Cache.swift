//
//  Cache.swift
//  SwiftTips
//
//  Created by hwh on 15/11/6.
//  Copyright © 2015年 hwh. All rights reserved.
//

import UIKit



class Cache: NSObject {
    let fileManager = NSFileManager.defaultManager()

    func storeFile(fileName: String,data: NSData!) -> Bool {
        
        let url = cachePath(fileName)
        if fileManager.fileExistsAtPath(url!.path!) {
            do {
                try fileManager.removeItemAtURL(url!)
            }catch {
                print("删除文件失败" + "\(error)")
                return false
            }
        }
        let sucess = data.writeToURL(url!, atomically: true)
        if sucess {
            print("[缓存成功]")
        }
        return sucess
    }
}


func cachePath(file:String) ->NSURL? {
    
    let fileManager = NSFileManager.defaultManager()
    var urlPath = fileManager.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
    let cache = urlPath[0].URLByAppendingPathComponent("swiftTips", isDirectory: true)
    
    return cache.URLByAppendingPathComponent(file, isDirectory: false)
}