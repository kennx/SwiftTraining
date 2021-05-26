//
//  WalkthroughViewController.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/26.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
  
  var walkthroughPageViewController: WalkthroughPageViewController?
  
  @IBOutlet var pageControl: UIPageControl!
  @IBOutlet var nextButton: UIButton! {
    didSet {
      nextButton.layer.cornerRadius = 25.0
      nextButton.layer.masksToBounds = true
    }
  }
  @IBOutlet var skipButton: UIButton!
  
  @IBAction func skipButtonTapped(sender: UIButton) {
    UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func nextButtonTapped(sender: UIButton) {
    if let index = walkthroughPageViewController?.currentIndex {
      switch index {
      case 0...1:
        walkthroughPageViewController?.forwardPage()
      case 2:
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
      default: break
      }
    }
    updateUI()
  }
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destination = segue.destination
    if let pageViewController = destination as? WalkthroughPageViewController {
      walkthroughPageViewController = pageViewController
      walkthroughPageViewController?.walkthroughDelegate = self
    }
  }
  
  
  func didUpdatePageIndex(currentIndex: Int) {
    updateUI()
  }
  
  
  func updateUI() {
    if let index = walkthroughPageViewController?.currentIndex {
      switch index {
      case 0...1:
        nextButton.setTitle("NEXT", for: .normal)
        skipButton.isHidden = false
      case 2:
        nextButton.setTitle("GET STARTED", for: .normal)
        nextButton.isHidden = true
      default: break
      }
      pageControl.currentPage = index
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
