//
//  EditRecipeTableViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-21.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class EditRecipeTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    @IBOutlet weak var cookTimePicker: ExpandablePickerView!
    @IBOutlet weak var prepTimePicker: ExpandablePickerView!
    
    var headerView: ParallaxHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ingredientsTextView.delegate = self
        self.instructionsTextView.delegate = self
        
        self.nameTextField.delegate = self
        self.difficultyTextField.delegate = self
        
        headerView = ParallaxHeaderView.parallaxHeaderViewWithImage(UIImage(named: "ImagePlaceHolder"), forSize: CGSizeMake(self.tableView.frame.size.width, 200)) as! ParallaxHeaderView
        self.tableView.tableHeaderView = headerView
        
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
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        headerView.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
        tableView.tableHeaderView = headerView
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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if (sender.isEqual(cookTimePicker)) {
            self.cookTimeTextField.text = dateFormatter.stringFromDate(cookTimePicker.date)
        }
        else {
            self.prepTimeTextField.text = dateFormatter.stringFromDate(prepTimePicker.date)
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // If the replacement text is "\n" and the
        // text view is the one you want bullet points
        // for
        
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
        print("image tapped")
    }
}
