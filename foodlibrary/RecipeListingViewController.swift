//
//  RecipeListingViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-19.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category!
    var recipes: [Recipe]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addTapped))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "RecipeListingTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeListingTableViewCell")
        
        self.fetchAllRecipes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchAllRecipes()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableViewDelegate
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeListingTableViewCell", forIndexPath: indexPath) as! RecipeListingTableViewCell
        
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let recipe: Recipe! = self.recipes[indexPath.row]
        let recipeViewController: RecipeViewController = RecipeViewController()
        recipeViewController.recipe = recipe
        
        self.navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    // MARK: Actions
    
    func addTapped() {
//        let editRecipeViewController:EditRecipeViewController = EditRecipeViewController()
//        editRecipeViewController.category = self.category
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("EditRecipeViewController") as! EditRecipeViewController
        
        let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
        
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
        
        
    }
    
    // MARK: MagicalRecord Methods
    func fetchAllRecipes() {
        recipes = Recipe.findAllSortedBy("name", ascending: true) as! [Recipe]
    }
}
