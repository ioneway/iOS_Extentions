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
    func base64Decoding() ->String?{
        let plainData: NSData? = self.dataUsingEncoding(NSUTF8StringEncoding);
        if let data: NSData = plainData {
            return  data.base64EncodedStringWithOptions(.Encoding64CharacterLineLength);
        }
        return nil;
    }
    
    /**
     将字符串base64编码
     
     - returns: 返回base64字符串
     */
    func base64Encoding() ->String?{
        let decodedData: NSData? = NSData(base64EncodedString: self, options: .IgnoreUnknownCharacters);
        if let data: NSData = decodedData {
            return String(data: data, encoding: NSUTF8StringEncoding);
        }

        return nil;
    }
    
    /// 返回字符串md5值
    func md5()->String?{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.dealloc(digestLen)
        return String(format: hash as String)
    }
}