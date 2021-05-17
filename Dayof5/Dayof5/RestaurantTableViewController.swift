//
//  RestaurantTableViewController.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/17.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
  
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
  
  var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]

  var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
  
  var restaurantIsVisited = Array(repeating: false, count: 21)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.cellLayoutMarginsFollowReadableWidth = true
  }



  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantNames.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "datacell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    cell.nameLabel.text = restaurantNames[indexPath.row]
    cell.locationLabel.text = restaurantLocations[indexPath.row]
    cell.typeLabel.text = restaurantTypes[indexPath.row]
    cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
    
    cell.heartTick.isHidden = !restaurantIsVisited[indexPath.row]

    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    
    if let popoverController = optionMenu.popoverPresentationController {
      if let cell = tableView.cellForRow(at: indexPath) {
        popoverController.sourceView = cell
        popoverController.sourceRect = cell.bounds
      }
    }
    
    let callAcionHandler = { (action: UIAlertAction!) -> Void in
      let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
      alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alertMessage, animated: true, completion: nil)
    }
    
    
    let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .default, handler: callAcionHandler)
    
    optionMenu.addAction(callAction)
    
    
    
    if let cell = tableView.cellForRow(at: indexPath) {
      let title = self.restaurantIsVisited[indexPath.row] == true ? "Undo Check-in" : "Check in"
      let checkInAction = UIAlertAction(title: title, style: .default, handler: { (action: UIAlertAction!) -> Void in
        let restaurantCell = cell as! RestaurantTableViewCell
        restaurantCell.heartTick.isHidden = self.restaurantIsVisited[indexPath.row]
        
        self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
      })
      optionMenu.addAction(checkInAction)
    }
    
    
    present(optionMenu, animated: true, completion: nil)
    
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
}
