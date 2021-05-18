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
  
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
//    
//    if let popoverController = optionMenu.popoverPresentationController {
//      if let cell = tableView.cellForRow(at: indexPath) {
//        popoverController.sourceView = cell
//        popoverController.sourceRect = cell.bounds
//      }
//    }
//
//    let callAcionHandler = { (action: UIAlertAction!) -> Void in
//      let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
//      alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//      self.present(alertMessage, animated: true, completion: nil)
//    }
//
//
//    let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .default, handler: callAcionHandler)
//
//    optionMenu.addAction(callAction)
//
//
//
//    let title = self.restaurantIsVisited[indexPath.row] ? "Undo Check-in" : "Check in"
//
//    let checkInAction = UIAlertAction(title: title, style: .default, handler: { (action: UIAlertAction!) -> Void in
//      let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
//      cell.heartTick.isHidden = self.restaurantIsVisited[indexPath.row]
//      self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
//    })
//    optionMenu.addAction(checkInAction)
//
//
//    present(optionMenu, animated: true, completion: nil)
//
//    tableView.deselectRow(at: indexPath, animated: false)
//  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
      self.restaurantNames.remove(at: indexPath.row)
      self.restaurantLocations.remove(at: indexPath.row)
      self.restaurantTypes.remove(at: indexPath.row)
      self.restaurantIsVisited.remove(at: indexPath.row)
      self.restaurantImages.remove(at: indexPath.row)
      
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      
      completionHandler(true)
    }
    
    let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
      let defaultText = "Just checking in at \(self.restaurantNames[indexPath.row])"
      let activityController: UIActivityViewController
      if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
        activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
      } else {
        activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
      }
      
      if let popoverController = activityController.popoverPresentationController {
        if let cell = tableView.cellForRow(at: indexPath) {
          popoverController.sourceView = cell
          popoverController.sourceRect = cell.bounds
        }
      }
      
      self.present(activityController, animated: true, completion: nil)
      completionHandler(true)
    }
    
    deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    deleteAction.image = UIImage(systemName: "trash")
    shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    shareAction.image = UIImage(systemName: "square.and.arrow.up")
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    
    
    
    return swipeConfiguration
  }
  
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    
    let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
    
    let tickAction = UIContextualAction(style: .normal, title: "tick") { (action, sourceView, completionHandler) in
      
      self.restaurantIsVisited[indexPath.row].toggle()
      cell.heartTick.isHidden = !self.restaurantIsVisited[indexPath.row]
      completionHandler(true)
    }
    
    tickAction.backgroundColor = UIColor(red: 79.0/255.0, green: 157.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    tickAction.image = self.restaurantIsVisited[indexPath.row] ? UIImage(named: "undo") : UIImage(named: "tick")
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [tickAction])
    
    tableView.deselectRow(at: indexPath, animated: false)
    
    return swipeConfiguration
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRestaurantDetail" {
      print("ddddccc", "===========>")
      if let indexPath = tableView.indexPathForSelectedRow {
        print(indexPath.row, "-------------->")
        let destinationController = segue.destination as! RestaurantDetailViewController
        destinationController.restaurantImageName = restaurantImages[indexPath.row]
        destinationController.restaurantName = restaurantNames[indexPath.row]
        destinationController.restaurantTypeName = restaurantTypes[indexPath.row]
        destinationController.restaurantLocationName = restaurantLocations[indexPath.row]
      }
    }
  }
  
}
