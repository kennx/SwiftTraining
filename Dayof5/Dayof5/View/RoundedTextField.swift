//
//  RoundedTextField.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/22.
//

import UIKit

class RoundedTextField: UITextField {
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
  let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = 5.0
    self.layer.masksToBounds = true
  }
  
}
