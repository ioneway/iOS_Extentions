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

/**
 *  利用UIControler添加点击事件
 *
 *  @param target 事件接收对象
 *  @param action 执行操作
 
 *  @warning action消息参数为UIControl而非UIView
 */
-(void)tapEventWithTarget:( _Nonnull id)target action:( _Nonnull SEL)action;

/**
 *  利用UITapGestureRecognizer添加点击事件
 *
 *  @param target 事件接收对象
 *  @param action 执行操作
 
 *  @warning action消息参数为UITapGestureRecognizer而非UIView
 */
-(void)tapGestureWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action;

/**
 *  利用UITapGestureRecognizer添加点击事件回调
 *
 *  @param block 接收一个UIGestureRecognizer对象，回调。
 */
-(void)tapGestureWithBlock:(void (^ _Nonnull )(UIGestureRecognizer * _Nonnull sender))block;
@end
