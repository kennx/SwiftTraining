//
//  UINavigationController+Ext.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/20.
//

import UIKit

extension UINavigationController {
  open override var childForStatusBarStyle: UIViewController? {
    return topViewController
  }
}
