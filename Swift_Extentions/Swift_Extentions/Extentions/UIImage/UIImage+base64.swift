//
//  UIImage+Util.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /**
     返回UIImage的base64
     
     - returns: 返回base64
     */
    func base64() ->String
    {
        let imageData: NSData;
        let mimeType: String;
        
        if self.hasAlpha() {
            imageData = UIImagePNGRepresentation(self)!;
            mimeType = "image/png";
        } else {
            imageData = UIImageJPEGRepresentation(self, 1.0)!;
            mimeType = "image/jpeg";
        }
        
        let base64Str: String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength);
        
        return "data:" + "\(mimeType)" + ";base64," + "\(base64Str)";
    }
    
    /**
     base64字符串转换为UIImage
     
     - parameter base64Str base64字符串
     
     - returns: 转换后的UIImage
     */
    static func fromeBase64(base64Str: String) ->UIImage?
    {
        let data: NSData = NSData(base64EncodedString: base64Str, options: .IgnoreUnknownCharacters)!;
        let image: UIImage? = UIImage(data: data);
        
        return image;
    }
    
    /**
     图片旋转
     
     - parameter orientation: 旋转方向，UIImageOrientation枚举
     
     - returns: 返回旋转后的图片
     */
    func rotaition(orientation: UIImageOrientation) ->UIImage
    {
        let rotate: Double;
        let rect: CGRect;
        let translateX: CGFloat;
        let translateY: CGFloat;
        var scaleX: CGFloat = 1.0;
        var scaleY: CGFloat = 1.0;
        
        let width: CGFloat = self.size.width;
        let height: CGFloat = self.size.height;
        
        switch (orientation) {
        case .Left:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, height, width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case .Right:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, height, width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case .Down:
            rotate = M_PI;
            rect = CGRectMake(0, 0, width, height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, width, height);
            translateX = 0;
            translateY = 0;
            break;
        }
        
        UIGraphicsBeginImageContext(rect.size);
        let context: CGContextRef? = UIGraphicsGetCurrentContext();
        if let context: CGContextRef = context{
            //做CTM变换
            CGContextTranslateCTM(context, 0.0, rect.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextRotateCTM(context, CGFloat(rotate));
            CGContextTranslateCTM(context, translateX, translateY);
            
            CGContextScaleCTM(context, scaleX, scaleY);
            //绘制图片
            CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
        }
        let newPic: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        
        return newPic;
    }
    
    
    //MARK: - Private Method
    private func hasAlphao() ->Bool
    {
        let alpha: CGImageAlphaInfo = CGImageGetAlphaInfo(self.CGImage);
        return (alpha == .First ||
            alpha == .Last ||
            alpha == .PremultipliedFirst ||
            alpha == .PremultipliedLast);
    }
    
    
}