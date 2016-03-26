//
//  UIAPPlication+Extension.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/6.
//  Copyright © 2016年 王伟. All rights reserved.
//
import UIKit

extension UIApplication {
    
    /// 是否是iphone4屏幕
    static let isiPhone4 = {
        return (UIScreen.mainScreen().bounds.size.height == 480);
    }()
    
    /// 屏幕size
    static let screenBounds = {
        return UIScreen.mainScreen().bounds;
    }()
    
    /// 屏幕宽度
    static let screenWidth: CGFloat = {
        let width: CGFloat = UIScreen.mainScreen().bounds.width;
        return width;
    }()
    
    /// 屏幕高度
    static let screenHeight: CGFloat = {
        let width: CGFloat = UIScreen.mainScreen().bounds.height;
        return width;
    }()
    
    /// 是否隐藏StatusBar
    static var hiddeStatusBar:Bool {
        get{
            let window = UIApplication.sharedApplication().keyWindow;
            return window?.windowLevel > UIWindowLevelStatusBar;
        }
        set{
            let window = UIApplication.sharedApplication().keyWindow;
            if(newValue){
                window?.windowLevel = UIWindowLevelStatusBar + 1;
            }else{
                window?.windowLevel = UIWindowLevelStatusBar - 1;
            }
        }
    }
    
    /**
     按比例计算宽度
     
     - parameter width: 假设屏宽320点为基准的宽度
     
     - returns: 返回以实际屏宽为基准的宽度
     */
    class func scaleWidth(width:CGFloat) ->CGFloat {
        return (width)*(kScreenWidth()/320.0);
    }
    
    /**
     按比例计算宽度
     
     - parameter width: 假设屏宽320点为基准的宽度
     
     - returns: 返回以实际屏宽为基准的宽度
     */
   class func scaleHeight(height:CGFloat) ->CGFloat {
        let height1 = height*kScreenHeight()/480.0;
        let height2 = height*kScreenHeight()/568.0;
        if UIApplication.isiPhone4{
            return height1;
        }else{
            return height2;
        }
    }
    
    /**
     打印日志函数，Release下自动关闭
     
     - parameter message: 消息
     - parameter file:    文件名
     - parameter method:  函数名
     - parameter line:    行号
     */
    class func printLog<T>(message: T,
        file: String = __FILE__,
        method: String = __FUNCTION__,
        line: Int = __LINE__)
    {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}
