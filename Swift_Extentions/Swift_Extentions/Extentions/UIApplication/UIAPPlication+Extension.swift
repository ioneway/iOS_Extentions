//
//  UIAPPlication+Extension.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/6.
//  Copyright © 2016年 王伟. All rights reserved.
//
import UIKit

extension UIApplication {
    
    /// 是否是iphone4
    static var isiPhone4: Bool {
        get{
            return (UIScreen.mainScreen().bounds.size.height == 480.0);
        }
    }
    
    /// 是否是iphone5
    static var isiPhone5: Bool {
        get{
            return (UIScreen.mainScreen().bounds.size.height == 568.0);
        }
    }
    /// 是否是iphone6
    static var isiPhone6: Bool {
        get{
            return (UIScreen.mainScreen().bounds.size.height == 667.0);
        }
    }
    /// 是否是iphone6plus
    static var isiPhone6plus: Bool {
        get{
            return (UIScreen.mainScreen().bounds.size.height ==  736.0);
        }
    }
    
    /// 判断是否是ipad
    static var isIPad: Bool {
        get {
            return UI_USER_INTERFACE_IDIOM() == .Pad;
        }
    }
    
    /// 判断是否是iphone
    static var isIPhone: Bool {
        get {
            return UI_USER_INTERFACE_IDIOM() == .Phone;
        }
    }
    
    /// 屏幕size
    static var screenBounds: CGRect{
        get {
            return UIScreen.mainScreen().bounds;

        }
    }
    
    /// 屏幕宽度
    static var screenWidth: CGFloat {
        get{
            let width: CGFloat = UIScreen.mainScreen().bounds.width;
            return width;
        }
    }
    
    /// 屏幕高度
    static var screenHeight: CGFloat  {
        get{
            let height: CGFloat = UIScreen.mainScreen().bounds.height;
            return height;
        }
    }
    
    /// 返回app的版本号
    static var appVersion: String {
        get {
            let versionstr = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String;
            return versionstr;
        }
    }
    
    /// 返回系统版本号
    static var systemVersion: String {
        get {
            let versionstr = UIDevice.currentDevice().systemVersion;
            return versionstr;
        }
    }
    
    /// 返回应用的uuid
    static var uuid: String {
        get{
            let uuid: CFUUIDRef = CFUUIDCreate(nil);
            let uuidStr: CFStringRef = CFUUIDCreateString(nil, uuid);
            let result: String = CFStringCreateCopy( nil, uuidStr) as String;
            
            return result;
        }
    }

    /// 返回app的displayName
    static var displayName: String {
        get {
            let name = NSBundle.mainBundle().infoDictionary!["CFBundleDisplayName"] as! String;
            return name;
        }
    }
    
    /// 是否隐藏StatusBar,默认为false
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
     按比例计算高度
     
     - parameter height: 假设屏宽480点为基准的高度
     
     - returns: 返回以实际屏高为基准的高度
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
