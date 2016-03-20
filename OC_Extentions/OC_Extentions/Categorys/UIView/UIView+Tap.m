//
//  UIView+Tap.m
//  OC_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

#import "UIView+Tap.h"
#import <objc/runtime.h>
static const void *OWGestureRecognizerBlockKey = &OWGestureRecognizerBlockKey;

@interface UIView (Internal)
@property (nonatomic, copy, setter = setHandlerAction:, nullable) void (^handlerAction)(UIGestureRecognizer *sender);
@end

@implementation UIView (Tap)
#pragma mark-  点击事件

-(void)tapEventWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action
{
    UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
    control.backgroundColor = [UIColor clearColor];
    [control addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
}


-(void)tapGestureWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}


-(void)tapGestureWithBlock:(void (^ _Nonnull )(UIGestureRecognizer * _Nonnull sender))block
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    self.handlerAction = block;
    [self addGestureRecognizer:gesture];
    
}

- (void)action:(UIGestureRecognizer *)recognizer
{
    self.handlerAction(recognizer);
}

- (void)setHandlerAction:(void (^)(UIGestureRecognizer *sender))handlerAction
{
    objc_setAssociatedObject(self, OWGestureRecognizerBlockKey, handlerAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIGestureRecognizer *sender))handlerAction
{
    return objc_getAssociatedObject(self, OWGestureRecognizerBlockKey);
}

@end
