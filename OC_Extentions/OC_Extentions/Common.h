//
//  Common.h
//  OC_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

#ifndef Common_h
#define Common_h

//默认坐标相关宏定义
#define NavigationBar_HEIGHT 44
#define UILABEL_DEFAULT_FONT_SIZE 20.0f

/********系统相关宏*******/
//当前系统版本
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

#define IOS7Later [[[UIDevice currentDevice] systemVersion]floatValue]>=7

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kWidth(R) (R)*(kScreenWidth)/320
#define kHeight(R) (iPhone4?((R)*(kScreenHeight)/480):((R)*(kScreenHeight)/568))
/********颜色相关宏***********/
//十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kColor(R,G,B,A)     [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define kWhiteColor         [UIColor whiteColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kBlackColor         [UIColor blackColor]
#define kClearColor         [UIColor clearColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kYellowColor        [UIColor yellowColor]

#define kGreenColor      [UIColor greenColor]
#define kLineColor UIColorFromRGB(0xdbdbdb)

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif

//UserDefault的宏定义
#define USERDEFAULTS NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]

#endif /* Common_h */
