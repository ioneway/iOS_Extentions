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


-(nullable UIImageView *)snapshot;
-(void)subViewsTreeWithIndentation:(int)indentation;
-(void)tapEventWithTarget:( _Nonnull id)target action:( _Nonnull SEL)action;
-(void)tapGestureWithTarget:( _Nonnull id)target action:( _Nonnull SEL)action;
-(void)tapGestureWithBlock:(void (^ _Nonnull )(UIGestureRecognizer * _Nonnull sender))block;
@end
