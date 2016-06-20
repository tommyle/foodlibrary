//
//  RecipeViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-06-19.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections: NSMutableArray!
    var recipe: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(editTapped))
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.registerNib(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")        
        
        self.sections = ["Name", "Photo", "Information", "Ingredients", "Instructions"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EditRecipeTableViewCell
        return 100
    }
    
    func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        return sections[section] as? String
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeTableViewCell", forIndexPath: indexPath) as! RecipeTableViewCell
                
        let sectionTitle:String = (sections[indexPath.section] as? String)!
        
        if (sectionTitle == "Ingredients") {
            cell.textLabel!.text = "1 cup of wheat\n1/2 ounce of coconuts"
        }
        else if (sectionTitle == "Directions") {
            cell.textLabel!.text = "1. Open the box\n2. Put ingredients in the box.\n3. Bake for 100 hours"
        }
        else {
            cell.textLabel!.text = "Filler text"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: Actions
    
    func editTapped() {
        
    }

}
