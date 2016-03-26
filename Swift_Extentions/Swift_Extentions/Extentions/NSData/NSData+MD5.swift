//
//  NSData.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

//@warn 需要添加桥接文件：import <CommonCrypto/CommonCrypto.h>
import Foundation


extension NSData {
    
    /// 返回字符串的MD5值
    func md5()->String {
        // Create byte array of unsigned chars
        let digestLen = Int(CC_MD5_DIGEST_LENGTH);
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen);
        // Create 16 byte MD5 hash value, store in buffer
        CC_MD5(self.bytes, CC_LONG(self.length), result);
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.dealloc(digestLen)
        return String(format: hash as String)
    }
}