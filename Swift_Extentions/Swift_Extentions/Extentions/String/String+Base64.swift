//
//  String+Base64.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

import Foundation

extension String {
    
    /**
     将base64字符串解码
     
     - returns: 返回原始字符串
     */
    var base64Decoding: String?{
        get{
            let decodedData: NSData? = NSData(base64EncodedString: self, options: .IgnoreUnknownCharacters);
            if let data: NSData = decodedData {
                return String(data: data, encoding: NSUTF8StringEncoding);
            }
            
            return nil;
        }
    }
    
    /**
     将字符串base64编码
     
     - returns: 返回base64字符串
     */
    var base64Encoding: String?{
        get{
            let decodedData: NSData? = NSData(base64EncodedString: self, options: .IgnoreUnknownCharacters);
            if let data: NSData = decodedData {
                return String(data: data, encoding: NSUTF8StringEncoding);
            }
            
            return nil;
        }
    }
}