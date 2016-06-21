//
//  EditRecipeTableViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-21.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 300.0
private let kTableHeaderCutAway: CGFloat = 60.0

class EditRecipeTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ingredientsView: UITextView!
    
    var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        ingredientsView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderView()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (context) -> Void in
            [self]
            self.updateHeaderView()
            self.tableView.reloadData()
            }, completion: { (context) -> Void in
        })
    }
    
    func updateHeaderView() {
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway/2))
    }
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
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
