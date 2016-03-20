//
//  ViewController.m
//  OC_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view tapGestureWithTarget:nil action:@selector(click:)];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 200, 203)];
    [self.view addSubview:v];
    
    NSLog(@"%f", v.left);
}

- (void)click:(id)sender
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
