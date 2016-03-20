//
//  UIView+Tap.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/20.
//  Copyright © 2016年 王伟. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

extension UIView {
  
    var closure: ((sender: UIGestureRecognizer)->()){
        get{
            return self.closure;
        }
        set{
            self.closure = newValue;
        }
    }
    /**
     利用UIControler添加点击事件
     
     - parameter target:  事件接收对象
     - parameter aaction: 执行操作
     */
    func addTapEventWithTarget(target: AnyObject?, action aaction: Selector){
        let control: UIControl = UIControl(frame: self.bounds);
        control.backgroundColor = UIColor.clearColor();
        control .addTarget(target, action: aaction, forControlEvents: .TouchUpInside);
        
        self .addSubview(control);
    }
    
    /**
     利用UITapGestureRecognizer添加点击事件
     
     - parameter target:  事件接收对象
     - parameter aaction: 执行操作
     */
    func addTapGestureWithTarget(target: AnyObject?, action aaction: Selector){
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: aaction);
        self .addGestureRecognizer(gesture);
    }
    
    /**
     利用UITapGestureRecognizer添加点击事件回调
     
     - parameter closure: 接收一个UIGestureRecognizer对象，闭包回调。
     */
    func addTapGestureWithClosure(closure: (sender: UIGestureRecognizer)->()){
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleAction:");
        self.closure = closure;
        self .addGestureRecognizer(gesture);
    }
    
    private func handleAction(recognizer: UITapGestureRecognizer){
        self.closure(sender: recognizer)
    }
}