//
//  UIColor.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/6.
//  Copyright © 2016年 王伟. All rights reserved.
//

import UIKit

extension UIColor {

    /**
     通过十六进制颜色值和alpha值创建UIColor
     
     - parameter hex:   十六进制颜色值
     - parameter alpha: 透明度,默认为1.0
     
     - returns: 返回UIColor实例
     */
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.subString(fromIndex: 1)
        }
        
        let scanner = NSScanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.length) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
}
