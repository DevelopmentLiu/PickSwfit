//
//  SwfitAFNetworking.swift
//  PickSwfit
//
//  Created by hydom on 2017/5/24.
//  Copyright © 2017年 Liu. All rights reserved.
//

import UIKit
import AFNetworking

class SwfitAFNetworking: AFHTTPSessionManager {
    
    //单列
    static let sharedTools:SwfitAFNetworking = {
        
        let baseUrl = NSURL(string:"")!//服务器基础地址
    
        let manager = SwfitAFNetworking(baseURL:baseUrl as URL,sessionConfiguration:URLSessionConfiguration.default)
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json","text/html","text/plain","text/json","text/javascript") as? Set<String>
        return manager
        
    }()
    
    /**
     get请求
     
     - parameter urlString:  请求的url
     - parameter parameters: 请求的参数
     - parameter success:    请求成功回调
     - parameter failure:    请求失败回调
     */
    class func get(urlString:String,parameters:AnyObject?,success:((_ responseObject:AnyObject?) -> Void)?,failure:((_ error:NSError) -> Void)?) -> Void {
        
        SwfitAFNetworking.sharedTools.get(urlString, parameters: parameters, progress: { (Progress) in
            
        }, success: { (task, responseObject) in
            //如果responseObject不为空时
            if responseObject != nil {

                success!(responseObject as AnyObject)
            }
            
        }) { (task, error) in
            
            failure!((error as AnyObject) as! NSError)
        }
    }
    
    /**
     post请求
     
     - parameter urlString:  请求的url
     - parameter parameters: 请求的参数
     - parameter success:    请求成功回调
     - parameter failure:    请求失败回调
     */
    
    class func post(urlString:String,parameters:AnyObject?,success:((_ responseObject:AnyObject?) -> Void)?,failure:((_ error:NSError) -> Void)?) -> Void {
        
        SwfitAFNetworking.sharedTools.post(urlString, parameters: parameters, progress: { (progress) in
            
        }, success: { (task, responseObject) in
            
            //如果responseObject不为空时
            if responseObject != nil {
                
                success!(responseObject as AnyObject)
            }
            
        }) { (task, error) in
            
            failure!((error as AnyObject) as! NSError)
        }
    }
    
    /*文件上传
    
    - parameter urlString:                 请求的url
    - parameter parameters:                请求的参数
    - parameter constructingBodyWithBlock: 文件data
    - parameter uploadProgress:            上传进度
    - parameter success:                   请求成功回调
    - parameter failure:                   请求失败回调
    */
    class func POST(urlString: String, parameters: AnyObject?, constructingBodyWithBlock:((_ formData:AFMultipartFormData) -> Void)?, uploadProgress: ((_ progress:Progress) -> Void)?, success: ((_ responseObject:AnyObject?) -> Void)?, failure: ((_ error: NSError) -> Void)?) -> Void {
        
        
        SwfitAFNetworking.sharedTools.post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            
            constructingBodyWithBlock!(formData)
            
        }, progress: { (progress) in
            
            uploadProgress!(progress)
            
        }, success: { (task, objc) in
            
            if objc != nil {
                
                success!(objc as AnyObject)
                
            }
        }) { (task, error) in
            
            failure!((error as AnyObject) as! NSError)
        }
        
        
    }

    
 
}


