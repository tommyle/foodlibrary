//
//  EditRecipeTableViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-21.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class EditRecipeTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    @IBOutlet weak var cookTimePicker: ExpandablePickerView!
    @IBOutlet weak var prepTimePicker: ExpandablePickerView!
    
    var recipe: Recipe?
    var image: UIImage!
    var headerView: ParallaxHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.ingredientsTextView.delegate = self
//        self.instructionsTextView.delegate = self
        
        self.nameTextField.delegate = self
        
        // Parallax Header
        self.headerView = ParallaxHeader.instanciateFromNib()
        self.headerView.backgroundImage.image = UIImage(named: "ImagePlaceHolder")
        
        self.tableView.parallaxHeader.view = self.headerView
        self.tableView.parallaxHeader.height = 250
        self.tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.tableView.parallaxHeader.minimumHeight = 0

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.userInteractionEnabled = true
        
        self.cookTimePicker.translatesAutoresizingMaskIntoConstraints = false
        self.cookTimePicker.visible = false
        self.cookTimePicker.hidden = true
        
        self.prepTimePicker.translatesAutoresizingMaskIntoConstraints = false
        self.prepTimePicker.visible = false
        self.prepTimePicker.hidden = true
        
        self.cookTimePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.prepTimePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let dateString = "00:00"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateObj = dateFormatter.dateFromString(dateString)
        
        self.cookTimePicker.setDate(dateObj!, animated: true)
        self.prepTimePicker.setDate(dateObj!, animated: true)
        
        if (self.recipe != nil) {
            self.editExistingRecipe()
        }
        else {
            recipe = Recipe.createEntity() as? Recipe
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    func hidePickerViews() {
        if (self.prepTimePicker.visible == true) {
            self.prepTimePicker.hidePicker()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        else if (self.cookTimePicker.visible == true) {
            self.cookTimePicker.hidePicker()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    func editExistingRecipe() {
        let filePath = (applicationDocumentsDirectory as NSString).stringByAppendingPathComponent(self.recipe!.imagePath!)
        headerView.backgroundImage.image = UIImage(contentsOfFile: filePath)
        
        self.nameTextField.text = recipe?.name
        self.cookTimeTextField.text = Helper.dateToString((recipe?.cookTime)!)
        self.prepTimeTextField.text = Helper.dateToString((recipe?.prepTime)!)
        self.ingredientsTextView.text = recipe?.getIngredientsAsString()
        self.instructionsTextView.text = recipe?.getInstructinsAsString()
        
        self.cookTimePicker.setDate(recipe!.cookTime!, animated: false)
        self.prepTimePicker.setDate(recipe!.prepTime!, animated: false)
        
        self.ingredientsTextView.sizeToFit()
        self.instructionsTextView.sizeToFit()
    }
    
    // MARK - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        self.hidePickerViews()
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidBeginEditing(textView: UITextView) {
        self.hidePickerViews()
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 2) {
            if (self.cookTimePicker.visible == true) {
                 return 216.0
            }
            else {
                 return 0.0
            }
        }
        else if (indexPath.section == 0 && indexPath.row == 4) {
            if (self.prepTimePicker.visible == true) {
                return 216.0
            }
            else {
                return 0.0
            }
        }
        else if (indexPath.section > 0) {
            return 160.0
        }
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            if (self.cookTimePicker.visible == true) {
                self.cookTimePicker.hidePicker()
            }
            else {
                self.cookTimePicker.showPicker()
                self.prepTimePicker.hidePicker()
                self.view.endEditing(true)
            }
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        else if (indexPath.section == 0 && indexPath.row == 3) {
            if (self.prepTimePicker.visible == true) {
                self.prepTimePicker.hidePicker()
            }
            else {
                self.prepTimePicker.showPicker()
                self.cookTimePicker.hidePicker()
                self.view.endEditing(true)
            }
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        else {
            //If any other cell is tapped then hide the picker views
            self.cookTimePicker.hidePicker()
            self.prepTimePicker.hidePicker()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        if (sender.isEqual(cookTimePicker)) {
            self.cookTimeTextField.text = Helper.dateToString(cookTimePicker.date)
        }
        else {
            self.prepTimeTextField.text = Helper.dateToString(prepTimePicker.date)
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // If the replacement text is "\n" and the
        // text view is the one you want bullet points
        // for
        
        //if this is the first character, add a bullet point
        if (textView.text == "") {
            textView.text = "\u{2022} "
            
            return true
        }
        
        //if backspace was presesed
        if (text == "") {
            
            //easy case where the cursor is at the end of the string
            if range.location == textView.text.characters.count - 1 {
                let str = textView.text
                let substring = str.substringWithRange(str.endIndex.advancedBy(-3)..<str.endIndex)
                
                //if the last occurance of the bullet was at the end then delete the bullet
                if (substring == "\n\u{2022} ") {
                    textView.text = str.substringWithRange(str.startIndex..<str.endIndex.advancedBy(-3))
                    return false
                }
            }
            else {
                //Hard case where the user deletes a bullet in the middle of the list
            }
        }
        
        if (text == "\n") {
            // If the replacement text is being added to the end of the
            // text view, i.e. the new index is the length of the old
            // text view's text...
            
            
            if range.location == textView.text.characters.count {
                // Simply add the newline and bullet point to the end
                let updatedText: String = textView.text!.stringByAppendingString("\n\u{2022} ")
                textView.text = updatedText
            }
            else {
                
                // Get the replacement range of the UITextView
                let beginning: UITextPosition = textView.beginningOfDocument
                let start: UITextPosition = textView.positionFromPosition(beginning, offset: range.location)!
                let end: UITextPosition = textView.positionFromPosition(start, offset: range.length)!
                let textRange: UITextRange = textView.textRangeFromPosition(start, toPosition: end)!
                // Insert that newline character *and* a bullet point
                // at the point at which the user inputted just the
                // newline character
                textView.replaceRange(textRange, withText: "\n\u{2022} ")
                // Update the cursor position accordingly
                let cursor: NSRange = NSMakeRange(range.location + "\n\u{2022} ".length, 0)
                textView.selectedRange = cursor
            }
            
            return false
            
            
        }
        // Else return yes
        return true
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        self.pickPhoto()
    }
}


// MARK: - Image Picker Controller Delegate

extension EditRecipeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Called when the user has selected a photo in the image picker.
        
        // "[NSObject : AnyObject]" indicates that input parameter, info, is a dictionary with keys of type NSObject and values of type AnyObject.
        
        // Use the UIImagePickerControllerEditedImage key to retrieve a UIImage object that contains the image after the Move and Scale operations on the original image.
        self.image = info[UIImagePickerControllerEditedImage] as! UIImage?
        
        if (recipe!.imagePath != nil) {
            if let imageToDelete = recipe!.imagePath {
                ImageSaver.deleteImageAtPath(imageToDelete)
            }
        }
        
        if ImageSaver.saveImageToDisk(image!, andToRecipe: self.recipe!) {
            showImage(image!)
        }

        tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    //#####################################################################
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    //#####################################################################
    
    func pickPhoto() {
        
        if true || UIImagePickerController.isSourceTypeAvailable(.Camera) {
            // Adding "true ||" introduces into the iOS Simulator fake availability of the camera.
            
            // The user's device has a camera.
            showPhotoMenu()
            
        } else {
            // The user's device does not have a camera.
            choosePhotoFromLibrary()
        }
    }
    //#####################################################################
    
    func showPhotoMenu() {
        // Show an alert controller with an action sheet that slides in from the bottom of the screen.
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // handler: is given a Closure that calls the appropriate method.
        // The "_" wildcard is being used to ignore the parameter that is passed to this closure (which is a reference to the UIAlertAction itself).
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default, handler: { _ in self.takePhotoWithCamera() })
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .Default, handler: { _ in self.choosePhotoFromLibrary() })
        alertController.addAction(chooseFromLibraryAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    //#####################################################################
    
    func takePhotoWithCamera() {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .Camera
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //------------------------------------------
        // Make the photo picker's tint color (background color) the same as the view's.
        // This avoids having standard blue text on a dark gray navigation bar (assuming the view's tint color is set appropriately in the storyboard).
        imagePicker.view.tintColor = view.tintColor
        
        //------------------------------------------
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    //#####################################################################
    
    func choosePhotoFromLibrary() {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .PhotoLibrary
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //------------------------------------------
        // Make the photo picker's tint color (background color) the same as the view's.
        // This avoids having standard blue text on a dark gray navigation bar (assuming the view's tint color is set appropriately in the storyboard).
        imagePicker.view.tintColor = view.tintColor
        
        //------------------------------------------
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    //#####################################################################
    
    func showImage(image: UIImage) {
        
        // Put the image into the image view.
//        imageView.image = image
        self.headerView.backgroundImage.image = image
    }
    //#####################################################################
}
