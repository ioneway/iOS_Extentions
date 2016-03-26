//
//  UIImage+Scale.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/21.
//  Copyright © 2016年 王伟. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /**
     自定义尺寸缩放
     
     - parameter size: 缩放尺寸
     */
    func scaleSize(size: CGSize)->UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, hasAlpha, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    
    /**
     图片等比例缩放
     
     - parameter ratio: 缩放比例
     
     - returns: 返回缩放后的图片
     */
    func scaleRatio(ratio: CGFloat)->UIImage{
        UIGraphicsBeginImageContext(CGSizeMake(self.size.width * ratio, self.size.height * ratio))
        self.drawInRect(CGRectMake(0, 0, self.size.width * ratio, self.size.height * ratio))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    /**
     裁剪图片
     
     - parameter croprect: 需要裁剪的CGRect
     
     - returns: 返回裁剪后的图片
     */
    func cropRect(croprect: CGRect)->UIImage?{
        
        // Draw new image in current graphics context
        let imageRef: CGImageRef? = CGImageCreateWithImageInRect(self.CGImage, croprect);
        
        if let imageRef = imageRef {
            let croppedImage: UIImage = UIImage(CGImage: imageRef);
            return croppedImage;
        }

       // CGImageRelease(imageRef);
        return nil;
    }
}