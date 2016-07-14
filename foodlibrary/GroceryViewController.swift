//
//  GroceryViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-11.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class GroceryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Oxygen-Regular", size: 18)!]
        self.navigationController!.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.tintColor = Helper.UIColorFromRGB(0x9274ED)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = false;
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "GroceryTableViewCell", bundle: nil), forCellReuseIdentifier: "GroceryTableViewCell")
        
        fetchAllCategories()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "GroceryTableViewCell"
        
        let cell : GroceryTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroceryTableViewCell
        
        let cateogry:Category = categories[indexPath.row]
        cell.label?.text = cateogry.name!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
        }
    }
    
    // MARK: MagicalRecord Methods
    func saveContext() {
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
    
    func fetchAllCategories() {
        categories = Category.findAllSortedBy("name", ascending: true) as! [Category]
    }

}
