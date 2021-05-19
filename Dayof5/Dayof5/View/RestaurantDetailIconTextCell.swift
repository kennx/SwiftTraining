//
//  RestaurantDetailIconTextCellTableViewCell.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/19.
//

import UIKit

class RestaurantDetailIconTextCell: UITableViewCell {
  
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var shortTextLabel: UILabel! {
    didSet {
      shortTextLabel.numberOfLines = 0
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
