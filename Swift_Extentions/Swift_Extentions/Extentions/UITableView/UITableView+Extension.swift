//
//  TableView+Extension.swift
//  Swift_Extentions
//
//  Created by weiwang on 16/3/6.
//  Copyright © 2016年 王伟. All rights reserved.
//
import UIKit

public extension UITableView {
    
    /**
     通过类名注册Cell
     @warn: 重用标识符为：类名
     - parameter cellClass: 类型
     */
    func registerCellClass(cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.registerClass(cellClass, forCellReuseIdentifier: identifier)
    }
    
    /**
     通过NIb文件注册Cell
     @warn:重用标识符为：类名；注意：Nib文件名必须与类名一致
     - parameter cellClass: 类型
     */
    func registerCellNib(cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier: identifier)
    }
    
    /**
     通过NIb文件注册HeaderFooterView
     @warn:重用标识符为：类名；
     - parameter cellClass: 类型
     */
    func registerHeaderFooterViewClass(viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        self.registerClass(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /**
     通过NIb文件注册HeaderFooterView
     @warn:重用标识符为：类名；注意：Nib文件名必须与类名一致
     - parameter cellClass: 类型
     */
    func registerHeaderFooterViewNib(viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.registerNib(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}