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


@end
