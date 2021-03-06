//
//  UIView+Extention.swift
//  OWMovableTableView
//
//  Created by weiwang on 16/3/15.
//  Copyright © 2016年 王伟. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    /**
     返回任意UIView的截图
     
     - returns: 返回截图(UIImageView类型)
     */
    func snapshot() ->UIImageView
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!);
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        let snapshot :UIImageView = UIImageView(image: img);
        
        return snapshot;
    }
    
    /**
     打印当前view的子树结构
     
     - parameter indentation: 打印层次
     */
    func subViewsTree(indentation indentation : Int16){
        let subViews: [UIView] = self.subviews;
        for i in 0..<subViews.count {
            let currentSubView = subviews[i];
            var currentViewDescription = String();
            for _ in 0...indentation {
                currentViewDescription = currentViewDescription + " ";
            }
            currentViewDescription = currentViewDescription + "\(i): " + "\(currentSubView.classForCoder)"
            UIApplication.printLog(currentViewDescription);

            currentSubView .subViewsTree(indentation: indentation+1);
        }
    }
    
    
    // http://stackoverflow.com/a/34615469/3085137
    private static func firstAvailableUIViewController(fromResponder responder: UIResponder) -> UIViewController? {
        func traverseResponderChainForUIViewController(responder: UIResponder) -> UIViewController? {
            if let nextResponder = responder.nextResponder() {
                if let nextResp = nextResponder as? UIViewController {
                    return nextResp
                } else {
                    return traverseResponderChainForUIViewController(nextResponder)
                }
            }
            return nil
        }
        
        return traverseResponderChainForUIViewController(responder)
    }
    
    /**
     获取当前view的viewcontroller
     
     - returns: 返回当前view的viewcontroller
     */
    var viewController: UIViewController? {
        get{
            return UIView.firstAvailableUIViewController(fromResponder: self as UIResponder);
        }
    }
}
