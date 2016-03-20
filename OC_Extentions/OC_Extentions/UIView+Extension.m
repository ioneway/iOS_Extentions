//
//  UIView+Extension.m
//
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 王伟. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

static const void *OWGestureRecognizerBlockKey = &OWGestureRecognizerBlockKey;

@interface UIView (Internal)
@property (nonatomic, copy, setter = setHandlerAction:, nullable) void (^handlerAction)(UIGestureRecognizer *sender);
@end

@implementation UIView (Extension)
@dynamic left;

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
- (CGFloat)left
{
    return self.origin.x;
}

- (void)seLeft:(CGFloat)aLeft
{
    self.origin = CGPointMake(aLeft, self.top);
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setTop:(CGFloat)atop
{
    self.origin = CGPointMake(self.left, atop);
}
- (CGFloat)top
{
    return self.origin.y;
}


- (void)setBottom:(CGFloat)aBottom
{
    self.top = aBottom - self.height;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setRight:(CGFloat)aRight
{
    self.left = aRight - self.width;
}

#pragma mark-  截图
- (nullable UIImageView *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *snapshot = [[UIImageView alloc] initWithImage:image];
    return snapshot;
}

#pragma mark-  打印View子树
-(void)subViewsTreeWithIndentation:(int)indentation
{
    NSArray *subViews = [self subviews];
    
    for (int i = 0; i < subViews.count; i++) {
        UIView *currentSubView = [subViews objectAtIndex:i];
        
        NSMutableString *currentViewDescription = [[NSMutableString alloc] init];
        
        for (int j = 0; j <= indentation; j++) {
            [currentViewDescription appendString:@" "];
        }
        [currentViewDescription appendFormat:@"[%d]: '%@'", i, NSStringFromClass([currentSubView class])];
        
        NSLog(@"%@", currentViewDescription);
        
        [currentSubView subViewsTreeWithIndentation:indentation+1];
    }
}

#pragma mark-  点击事件
/**
 *  利用UIControler添加点击事件
 *
 *  @param target 事件接收对象
 *  @param action 执行操作
 
 *  @warning action消息参数为UIControl而非UIView
 */
-(void)tapEventWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action
{
    UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
    control.backgroundColor = [UIColor clearColor];
    [control addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
}

/**
 *  利用UITapGestureRecognizer添加点击事件
 *
 *  @param target 事件接收对象
 *  @param action 执行操作
 
 *  @warning action消息参数为UITapGestureRecognizer而非UIView
 */
-(void)tapGestureWithTarget:(_Nonnull id)target action:(_Nonnull SEL)action
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}

/**
 *  利用UITapGestureRecognizer添加点击事件回调
 *
 *  @param block 接收一个UIGestureRecognizer对象，回调。
 */
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
