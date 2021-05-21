//
//  ReviewViewController.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/21.
//

import UIKit

class ReviewViewController: UIViewController {
  
  @IBOutlet var backgroundImageView: UIImageView!
  
  @IBOutlet var rateButtons: [UIButton]!
  
  @IBOutlet var closeButton: UIButton!
  
  var restaurant = Restaurant()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundImageView.image = UIImage(named: restaurant.image)
    
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    let moveRightTransform = CGAffineTransform(translationX: 600, y: 0)
    let scaleTransform = CGAffineTransform(scaleX: 5.0, y: 5.0)
    let moveScaleTransform = scaleTransform.concatenating(moveRightTransform)
    
    let moveTopTransform = CGAffineTransform(translationX: 0, y: -500)
    
    for rateButton in rateButtons {
      rateButton.transform = moveScaleTransform
      rateButton.alpha = 0.0
    }
    
    closeButton.transform = moveTopTransform
    closeButton.alpha = 0.0
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    
    var delay = 0.05
    
    for rateButton in rateButtons {
      delay += 0.05
      UIView.animate(withDuration: 0.8, delay: delay, options: []) {
        rateButton.alpha = 1.0
        rateButton.transform = .identity
      }
    }
    
    UIView.animate(withDuration: 0.5, delay: delay) {
      self.closeButton.transform = .identity
      self.closeButton.alpha = 1.0
    }
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
