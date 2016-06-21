//
//  EditRecipeTableViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-21.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class EditRecipeTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ingredientsView: UITextView!
    
    var headerView: ParallaxHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsView.delegate = self
        
        headerView = ParallaxHeaderView.parallaxHeaderViewWithImage(UIImage(named: "bg-header"), forSize: CGSizeMake(tableView.frame.size.width, 300)) as! ParallaxHeaderView
        tableView.tableHeaderView = headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        headerView.layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - UITextViewDelegate
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
}
