//
//  UIImage+ReSize.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/6.
//  Copyright © 2016年 王伟. All rights reserved.

import Foundation
import UIKit

extension UIImage {
        
    /**
     以原始图片最短边为边长，以center为中心进行裁剪，得到一个正方形图片
     
     - returns: 裁剪后的图片
     */
    func centerMaxSquareImage() -> UIImage
    {
        var centerSquareSize: CGSize = self.size
        let oriImgWid: CGFloat = CGFloat(CGImageGetWidth(self.CGImage))
        let oriImgHgt: CGFloat = CGFloat(CGImageGetHeight(self.CGImage))
        if oriImgHgt <= oriImgWid {
            centerSquareSize.width = oriImgHgt
            centerSquareSize.height = oriImgHgt
        }
        else {
            centerSquareSize.width = oriImgWid
            centerSquareSize.height = oriImgWid
        }
        let x: CGFloat = (oriImgWid - centerSquareSize.width) / 2.0
        let y: CGFloat = (oriImgHgt - centerSquareSize.height) / 2.0
        let cropRect: CGRect = CGRectMake(x, y, centerSquareSize.height, centerSquareSize.width)
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect)!
        let cropped: UIImage = UIImage(CGImage: imageRef)
        return cropped
    }
    
    /**
     依据给出的CGRect裁剪图片
     
     - parameter bounds: 裁剪区域
     
     - returns: 返回裁剪后的图片
     */
    func croppedRect(bounds: CGRect) -> UIImage
    {
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(self.CGImage, bounds)!
        let croppedImage: UIImage = UIImage(CGImage:imageRef)
        return croppedImage
    }
    
    
    // Returns a rescaled copy of the image, taking into account its orientation
    // The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
    
    /**
    缩放图片
    
    - parameter newSize: 缩放后的尺寸
    - parameter quality: CGInterpolationQuality枚举：默认为.Default
    
    - returns: 返回缩放后的图片
    */
    func scaledSize(newSize: CGSize, interpolationQuality quality: CGInterpolationQuality = .Default) -> UIImage
    {
        var drawTransposed: Bool
        switch self.imageOrientation
        {
        case UIImageOrientation.Left,UIImageOrientation.LeftMirrored,UIImageOrientation.Right,UIImageOrientation.RightMirrored:
            drawTransposed = true
        default:
            drawTransposed = false
        }
        return self.scaleSize(newSize, transform: self.transformForOrientation(newSize), drawTransposed: drawTransposed, interpolationQuality: quality)
    }
    
    
    
    
    // Returns a copy of this image that is squared to the thumbnail size.
    // If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
    func thumbnailImage(thumbnailSize: Int, transparentBorder borderSize: UInt, cornerRadius: CGFloat, interpolationQuality quality: CGInterpolationQuality) -> UIImage
    {
        let thumbSizeImage:CGFloat = CGFloat( thumbnailSize)
        let resizedImage: UIImage = self.resizedImageWithContentMode(UIViewContentMode.ScaleAspectFill, bounds: CGSizeMake(thumbSizeImage, thumbSizeImage), interpolationQuality: quality)
        
        // Crop out any part of the image that's larger than the thumbnail size
        // The cropped rect must be centered on the resized image
        // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
        let cropRect: CGRect = CGRectMake(round((resizedImage.size.width - thumbSizeImage) / 2), round((resizedImage.size.height - thumbSizeImage) / 2), thumbSizeImage, thumbSizeImage)
        
        let croppedImage: UIImage = resizedImage.croppedImage(cropRect)
        
        let transparentBorderImage: UIImage = borderSize > 0 ? croppedImage.transparentBorderImage(CGFloat(borderSize)) : croppedImage
        return transparentBorderImage.roundedCornerImage(cornerRadius, borderSize: borderSize)
    }
    

    // Resizes the image according to the given content mode, taking into account the image's orientation
    func resizedImageWithContentMode(contentMode: UIViewContentMode, bounds: CGSize, interpolationQuality quality: CGInterpolationQuality) -> UIImage
    {
        let horizontalRatio: CGFloat = bounds.width / self.size.width
        let verticalRatio: CGFloat = bounds.height / self.size.height
        var ratio: CGFloat = 0
        let error: NSError = NSError.init(domain: "Error", code: 0, userInfo: nil)

        switch contentMode
        {
        case UIViewContentMode.ScaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case UIViewContentMode.ScaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
        default:
            NSException.raise(NSInvalidArgumentException, format: "Unsupported content mode: \(contentMode)", arguments: getVaList([error]))
        }
        let newSize: CGSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio)
        return self.scaleSize(newSize, interpolationQuality: quality)
    }
        
    // Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
    // The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
    // If the new size is not integral, it will be rounded up
    private func scaleSize(newSize: CGSize, transform: CGAffineTransform, drawTransposed transpose: Bool, interpolationQuality quality: CGInterpolationQuality) -> UIImage
    {
        let newRect: CGRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height))
        let transposedRect: CGRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width)
        let imageRef: CGImageRef = self.CGImage!

        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        // Build a context that's the same dimensions as the new size
        let bitmap: CGContextRef = CGBitmapContextCreate(nil, Int(newRect.size.width), Int(newRect.size.height), CGImageGetBitsPerComponent(imageRef), 0, CGImageGetColorSpace(imageRef),bitmapInfo.rawValue)!
        
        // Rotate and/or flip the image if required by its orientation
        CGContextConcatCTM(bitmap, transform)
        
        // Set the quality level to use when rescaling
        CGContextSetInterpolationQuality(bitmap, quality)
        
        // Draw into the context; this scales the image
        CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef)
        
        // Get the resized image from the context and a UIImage
        let newImageRef: CGImageRef = CGBitmapContextCreateImage(bitmap)!
        let newImage: UIImage = UIImage(CGImage:newImageRef)
        
        return newImage
    }
    
    // Returns an affine transform that takes into account the image orientation when drawing a scaled image
   private func transformForOrientation(newSize: CGSize) -> CGAffineTransform
    {
        var transform: CGAffineTransform = CGAffineTransformIdentity
        switch self.imageOrientation
        {
        case UIImageOrientation.Down,UIImageOrientation.DownMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            break;
            
        case UIImageOrientation.Left,UIImageOrientation.LeftMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            break;
            
        case UIImageOrientation.Right,UIImageOrientation.RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, newSize.height)
            transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2))
            break;
            
        default:
            break;
        }
        
        switch self.imageOrientation
        {
        case UIImageOrientation.UpMirrored,UIImageOrientation.DownMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            break;
            
        case UIImageOrientation.LeftMirrored,UIImageOrientation.RightMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.height, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            break;
            
        default:
            break;
        }
        
        return transform
    }
    

    

      

}
