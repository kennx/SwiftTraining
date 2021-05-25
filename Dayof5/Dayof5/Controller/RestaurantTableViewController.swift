//
//  RestaurantTableViewController.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/17.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
  
  
  func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
      filterContent(for: searchText)
      tableView.reloadData()
    }
  }
  
  
  var fetchResultsController: NSFetchedResultsController<RestaurantMO>!
  var searchController: UISearchController!
  
  var searchResults: [RestaurantMO] = []
  
  @IBOutlet var emptyRestaurantView: UIView!
  
  @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    dismiss(animated: true, completion: nil)
  }
  
  var restaurants: [RestaurantMO] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchController = UISearchController(searchResultsController: nil)
    
    searchController.searchBar.placeholder = "Search restaurants..."
    searchController.searchBar.barTintColor = .white
    searchController.searchBar.backgroundImage = UIImage()
    searchController.searchBar.tintColor = UIColor(red: 231, green: 76, blue: 60)
    
    tableView.tableHeaderView = searchController.searchBar
    tableView.backgroundView = emptyRestaurantView
    tableView.backgroundView?.isHidden = true
    tableView.cellLayoutMarginsFollowReadableWidth = true
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    
    let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
    
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
      let context = appDelegate.persistentContainer.viewContext
      fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      fetchResultsController.delegate = self
      
      do {
        try fetchResultsController.performFetch()
        if let fetchedObjects = fetchResultsController.fetchedObjects {
          restaurants = fetchedObjects
        }
      } catch {
        print(error.localizedDescription)
      }
    }
    
    if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
      navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), NSAttributedString.Key.font: customFont]
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnSwipe = true
  }
  
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    if restaurants.count > 0 {
      tableView.backgroundView?.isHidden = true
      tableView.separatorStyle = .singleLine
    } else {
      tableView.backgroundView?.isHidden = false
      tableView.separatorStyle = .none
    }
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive {
      return searchResults.count
    } else {
      return restaurants.count
    }
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return !searchController.isActive
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "datacell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
    cell.nameLabel.text = restaurant.name
    cell.locationLabel.text = restaurant.location
    cell.typeLabel.text = restaurant.type
    if let restaurantImage = restaurant.image {
      cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
    }
    cell.heartTick.isHidden = !restaurant.isVisited
    
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
      if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
        let context = appDelegate.persistentContainer.viewContext
        let restaurantToDelegate = self.fetchResultsController.object(at: indexPath)
        context.delete(restaurantToDelegate)
        appDelegate.saveContext()
      }
      completionHandler(true)
    }
    
    let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
      let defaultText = "Just checking in at \(self.restaurants[indexPath.row].name!)"
      let activityController: UIActivityViewController
      if let restaurantImage = self.restaurants[indexPath.row].image,
         let imageToShare = UIImage(data: restaurantImage as Data) {
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
      
      self.restaurants[indexPath.row].isVisited.toggle()
      cell.heartTick.isHidden = !self.restaurants[indexPath.row].isVisited
      completionHandler(true)
    }
    
    tickAction.backgroundColor = UIColor(red: 79.0/255.0, green: 157.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    tickAction.image = self.restaurants[indexPath.row].isVisited ? UIImage(named: "undo") : UIImage(named: "tick")
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [tickAction])
    
    tableView.deselectRow(at: indexPath, animated: false)
    
    return swipeConfiguration
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRestaurantDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as! RestaurantDetailViewController
        destinationController.restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
      }
    }
  }
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      if let newIndexPath = newIndexPath {
        tableView.insertRows(at: [newIndexPath], with: .fade)
      }
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    case .update:
      if let indexPath = indexPath {
        tableView.reloadRows(at: [indexPath], with: .fade)
      }
    default:
      tableView.reloadData()
    }
    
    if let fetchedObjects = controller.fetchedObjects {
      restaurants = fetchedObjects as! [RestaurantMO]
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func filterContent(for searchText: String) {
    searchResults = restaurants.filter({ (restaurant) -> Bool in
      if let name = restaurant.name,
         let location = restaurant.location {
        return name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
      } else if let location = restaurant.location {
        return location.localizedCaseInsensitiveContains(searchText)
      }
      return false
    })
  }

}
