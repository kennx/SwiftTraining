//
//  NewRestaurantController.swift
//  Dayof5
//
//  Created by 张剑 on 2021/5/22.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
  var restaurant: RestaurantMO!
  
  @IBOutlet var nameTextField: RoundedTextField! {
    didSet {
      nameTextField.tag = 1
      nameTextField.becomeFirstResponder()
      nameTextField.delegate = self
    }
  }
  
  @IBOutlet var typeTextField: RoundedTextField! {
    didSet {
      typeTextField.tag = 2
      typeTextField.delegate = self
    }
  }
  
  @IBOutlet var addressTextField: RoundedTextField! {
    didSet {
      addressTextField.tag = 3
      addressTextField.delegate = self
    }
  }
  
  @IBOutlet var phoneTextField: RoundedTextField! {
    didSet {
      phoneTextField.tag = 4
      phoneTextField.delegate = self
    }
  }
  
  @IBOutlet var descriptionTextView: UITextView! {
    didSet {
      descriptionTextView.tag = 5
      descriptionTextView.layer.cornerRadius = 5.0
      descriptionTextView.layer.masksToBounds = true
    }
  }
  
  
  @IBOutlet var photoImageView: UIImageView!

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.shadowImage = UIImage()
    if let customFont = UIFont(name: "Rubik-Medium", size: 35.0) {
      navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont]
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let nextTextField = view.viewWithTag(textField.tag + 1) {
      textField.resignFirstResponder()
      nextTextField.becomeFirstResponder()
    }
    return true
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
      
      let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          let imagePicker = UIImagePickerController()
          imagePicker.delegate = self
          imagePicker.allowsEditing = false
          imagePicker.sourceType = .camera
          self.present(imagePicker, animated: true, completion: nil)
        }
      }
      
      let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { action in
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
          let imagePicker = UIImagePickerController()
          imagePicker.delegate = self
          imagePicker.allowsEditing = false
          imagePicker.sourceType = .photoLibrary
          self.present(imagePicker, animated: true, completion: nil)
        }
      }
      
      photoSourceRequestController.addAction(cameraAction)
      photoSourceRequestController.addAction(photoLibraryAction)
      
      if let popoverController = photoSourceRequestController.popoverPresentationController {
        if let cell = tableView.cellForRow(at: indexPath) {
          popoverController.sourceView = cell
          popoverController.sourceRect = cell.bounds
        }
      }
      
      present(photoSourceRequestController, animated: true, completion: nil)
      
    }
  }
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photoImageView.image = selectedImage
      photoImageView.contentMode = .scaleAspectFill
      photoImageView.clipsToBounds = true
    }
    
    let leadingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
    leadingConstraint.isActive = true
    
    let trailingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
    trailingConstraint.isActive = true
    
    let topConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
    topConstraint.isActive = true
    
    let bottomConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
    bottomConstraint.isActive = true
    
    dismiss(animated: true, completion: nil)
  }
  
  private func showAlertMessage(content: String) {
    let alertController = UIAlertController(title: "warning", message: "\(content) cannt is empty!", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func saveButtonTapped(segue: AnyObject) {
    if let nameText = nameTextField.text,
       let addressText = addressTextField.text,
       let phoneText = phoneTextField.text,
       let typeText = typeTextField.text,
       let descText = descriptionTextView.text {
      if nameText.isEmpty {
        self.showAlertMessage(content: "Name")
      } else if typeText.isEmpty {
        self.showAlertMessage(content: "Type")
      } else if addressText.isEmpty {
        self.showAlertMessage(content: "Address")
      } else if phoneText.isEmpty {
        self.showAlertMessage(content: "Phone")
      } else if descText.isEmpty {
        self.showAlertMessage(content: "Description")
      } else {
        print("name: \(nameText)\naddress: \(addressText)\nphone: \(phoneText)\ntype: \(typeText)\ndescription: \(descText)")
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
          restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
          restaurant.name = nameText
          restaurant.type = typeText
          restaurant.location = addressText
          restaurant.phone = phoneText
          restaurant.summary = descText
          restaurant.isVisited = false
          
          if let restaurantImage = photoImageView.image {
            restaurant.image = restaurantImage.pngData()
          }
          
          dismiss(animated: true, completion: nil)
        }
        
      }
    }
    
  }
  
  
  
}
