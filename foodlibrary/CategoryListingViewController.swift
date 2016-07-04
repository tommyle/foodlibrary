//
//  CategoryListingViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-18.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class CategoryListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController!.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBarController!.tabBar.translucent = false
        
        //Hide the tabBar item title
        for tabBarItem in self.tabBarController!.tabBar.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        
//        self.navigationController!.toolbar.backgroundColor = UIColor.redColor()
//        self.navigationController!.toolbar.tintColor = UIColor.redColor()
        //        self.navigationController!.toolbar.barStyle = UIBarStyleBlack
        
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Oxygen-Regular", size: 18)!]
        self.navigationController!.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.tintColor = Helper.UIColorFromRGB(0x9274ED)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = false;
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addTapped))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.fetchAllCategories()
        
        //If not categories exist populate the database
        if (categories.count == 0) {
            self.createCategories()
            self.fetchAllCategories()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchAllCategories()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    func createCategories () {
        let deserts: Category!
        deserts = Category.createEntity() as! Category
        deserts.name = "All"
        
        let vegan: Category!
        vegan = Category.createEntity() as! Category
        vegan.name = "Favourites"
        
        self.saveContext();
    }

    // MARK: MagicalRecord Methods
    func saveContext() {
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
    
    func fetchAllCategories() {
        categories = Category.findAllSortedBy("name", ascending: true) as! [Category]
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let recipeListingViewController:RecipeListingViewController = RecipeListingViewController()
        recipeListingViewController.category = categories[indexPath.row]
        
        self.navigationController?.pushViewController(recipeListingViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let category:Category = categories[indexPath.row]
        
        if (category.name == "All") {
            return false
        }
        else {
            return true
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let category:Category = categories[indexPath.row]
            category.deleteEntity()
            
            NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
            
            self.categories.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // MARK: Actions
    
    func addTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddCategoryTableViewController") as! AddCategoryTableViewController
        
        let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
        
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }
}
