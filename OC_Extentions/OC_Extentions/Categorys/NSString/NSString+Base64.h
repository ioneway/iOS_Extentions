//
//  NSString+Base64.h
//  OC_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  将base64字符串解码
 *
 *  @return 返回原始字符串
 */
- (NSString *)base64Decoding;

/**
 *  将字符串base64编码
 *
 *  @return 返回base64字符串
 */
- (NSString *)base64Encoding;
@end
