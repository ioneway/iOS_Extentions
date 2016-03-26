//
//  String+Extention.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/26.
//  Copyright © 2016年 王伟. All rights reserved.
//

import Foundation

extension String {
    /**
     获取一个类的类型名
     
     - parameter aClass: 类 AnyClass类型
     
     - returns: 返回类型名称
     */
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!;
    }
    
    /**
     截取字符串
     
     - parameter from: 截取起始点
     
     - returns: 返回截取点到末尾的子串
     */
    func subString(fromIndex from: Int) -> String {
        return self.substringFromIndex(self.startIndex.advancedBy(from));
    }
    
    /**
      截取字符串
     
     - parameter to: 截取末点
     
     - returns: 返回末点之前的字符串
     */
    func subString(toIndex to: Int) -> String {
        return self.substringToIndex(self.endIndex.advancedBy(to));
    }
    
    /// 字符长度
    var length: Int {
        return self.characters.count;
    }
}