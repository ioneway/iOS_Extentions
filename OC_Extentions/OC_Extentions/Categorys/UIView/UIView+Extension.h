//
//  UIView+Extension.h
//
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 王伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat top;

/**
 *  生成任意View的截图
 *
 *  @return 返回UIIMageView
 */
-(nullable UIImageView *)snapshot;

/**
 *  打印任意View的subViews子树结构
 *
 *  @param indentation 层次
 */
-(void)subViewsTreeWithIndentation:(int)indentation;



@end
