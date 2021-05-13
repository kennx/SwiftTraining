//
//  ViewController.swift
//  Dayof1
//
//  Created by 张剑 on 2021/5/13.
//

import UIKit

class ViewController: UIViewController {
  
  @IBAction func showMessage(sender: UIButton) {
    let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alertController, animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

