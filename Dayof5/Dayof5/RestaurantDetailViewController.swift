//
//  RestaurantDetailViewController.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/18.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
  
  @IBOutlet var restaurantImageView: UIImageView!
  @IBOutlet var restaurantLocation: UILabel!
  @IBOutlet var restaurantType: UILabel!
  @IBOutlet var restaurantLabel: UILabel!
  
  var restaurantImageName = ""
  var restaurantLocationName = ""
  var restaurantTypeName = ""
  var restaurantName = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    restaurantImageView.image = UIImage(named: restaurantImageName)
    restaurantLabel.text = restaurantName
    restaurantType.text = restaurantTypeName
    restaurantLocation.text = restaurantLocationName
  }
  
  
  
}
