//
//  ViewController.swift
//  Dayof2
//
//  Created by 张剑 on 2021/5/14.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func showMessage(sender: UIButton) {
    let selectedButton = sender
    if let wordToLookup = selectedButton.titleLabel?.text {
      let emojiDict = ["👻": "Ghost", "🤖": "Robot", "😤": "Angry", "🤓": "Nerdy", "👾": "Alien monster"]
      let meaning = emojiDict[wordToLookup]
      let alertController = UIAlertController(title: "Meaning", message: meaning, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alertController, animated: true, completion: nil)
    }
    
  }


}

