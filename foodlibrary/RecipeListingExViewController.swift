//
//  RecipeListingExViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-10.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RecipeCollectionViewCell"
private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

class RecipeListingExViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var category: Category!
    var recipes: [Recipe]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView!.registerNib(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.backgroundColor = UIColor.clearColor()
        
        self.fetchAllRecipes()
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        let width = UIScreen.mainScreen().bounds.size.width - 40
        flow.itemSize = CGSizeMake(width/2, width/2)
        flow.minimumInteritemSpacing = 20
        flow.minimumLineSpacing = 20
        
        self.view.backgroundColor = Helper.UIColorFromRGB(0xf8f8fc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.recipes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:RecipeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RecipeCollectionViewCell
        
        let recipe: Recipe = recipes[indexPath.row]
        cell.setCell(recipe.name!, imagePath: recipe.imagePath!)
        
        return cell as UICollectionViewCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let recipe: Recipe! = self.recipes[indexPath.row]

        let recipeViewController = RecipeViewController()
        recipeViewController.recipe = recipe
        
        self.navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                                   sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //20 on each side plus 20 spacing in between items = 60
        let w = UIScreen.mainScreen().bounds.size.width - 60
        
        //w 153, h 201
        
        return CGSize(width: w/2, height: w/2 * 201/154)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    // MARK: MagicalRecord Methods
    func fetchAllRecipes() {
        if (category.name == "All") {
            recipes = Recipe.findAllSortedBy("name", ascending: true) as! [Recipe]
        }
        else {
            let predicate = NSPredicate(format: "category.name = %@", category.name!)
            recipes = Recipe.findAllSortedBy("name", ascending: true, withPredicate: predicate) as! [Recipe]
        }
        
    }
}
