//
//  RestaurantDetailTextCell.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/19.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {
  
  @IBOutlet var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.numberOfLines = 0
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
