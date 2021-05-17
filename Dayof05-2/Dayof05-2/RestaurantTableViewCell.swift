//
//  RestaurantTableViewCell.swift
//  Dayof05-2
//
//  Created by 张剑 on 2021/5/17.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
  
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var typeLabel: UILabel!
  @IBOutlet var thumbnailImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
