//
//  UIView+Tap.h
//  OC_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)

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
-(void)tapGestureWithBlock:(void (^ _Nonnull)(UIGestureRecognizer * _Nonnull sender))block;
@end
