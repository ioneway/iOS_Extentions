//
//  UIImage+Util.h
//  HelloCordova
//
//  Created by wangwei on 12/23/15.
//  Copyright © 2016年 王伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

/**
 *  图片转换为base64字符串
 *
 *  @return 返回base64值
 */
- (NSString *) toBase64;

/**
 *  base64字符串转换为UIImage
 *
 *  @param base64Str base64字符串
 *
 *  @return 转换后的UIImage
 */
+(UIImage *)fromeBase64:(NSString *)base64Str;

/**
 *  图片旋转
 *
 *  @param orientation 旋转方向，UIImageOrientation枚举
 *
 *  @return 旋转后的图片
 */
- (UIImage *)rotation:(UIImageOrientation)orientation;



@end
