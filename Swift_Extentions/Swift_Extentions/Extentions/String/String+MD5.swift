//
//  String+MD5.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

//@warn 需要添加桥接文件：import <CommonCrypto/CommonCrypto.h>
import Foundation

extension String {

    /// 返回字符串md5值
    func md5()->String {
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