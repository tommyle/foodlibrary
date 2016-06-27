//
//  AddCategoryTableViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-26.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class AddCategoryTableViewController: UITableViewController {

    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(saveTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action
    
    func saveTapped() {
        let category: Category =  Category.createEntity() as! Category
        
        category.name = categoryTextField.text
        
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancelTapped() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
