//
//  Methods.swift
//  ADSwitch
//
//  Created by weiwang on 16/3/6.
//  Copyright © 2016年 王伟. All rights reserved.
//

import Foundation
import UIKit


func isiPhone4() ->Bool{
    return (UIScreen.mainScreen().bounds.size.height == 480);
}

func kScreenBounds() ->CGRect{
    return UIScreen.mainScreen().bounds;
}

func kScreenWidth() -> CGFloat{
    return kScreenBounds().width;
}

func kScreenHeight() -> CGFloat{
    return kScreenBounds().height;
}

func kWidth(width:CGFloat) ->CGFloat {
    return (width)*(kScreenWidth()/320.0);
}

func kHeight(height:CGFloat) ->CGFloat {
    let height1 = height*kScreenHeight()/480.0;
    let height2 = height*kScreenHeight()/568.0;
    if isiPhone4(){
        return height1;
    }else{
        return height2;
    }
}