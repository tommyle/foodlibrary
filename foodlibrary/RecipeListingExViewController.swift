//
//  RecipeListingExViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-10.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit
import HidingNavigationBar

private let reuseIdentifier = "RecipeCollectionViewCell"
private let margin: CGFloat = 10.0
private let sectionInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)

class RecipeListingExViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, RecipeViewControllerDelegate {

    var hidingNavBarManager: HidingNavigationBarManager?

    var category: Category!
    var recipes: [Recipe]!
    var selectedIndexPath: NSIndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: self.collectionView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addTapped))
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView!.registerNib(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.backgroundColor = UIColor.clearColor()
        
        if (category.name == "All") {
            recipes = category.fetchAllRecipes()
        }
        else {
            recipes = category.fetchRecipes()
        }
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        let width = UIScreen.mainScreen().bounds.size.width - 40
        flow.itemSize = CGSizeMake(width/2, width/2)
        flow.minimumInteritemSpacing = margin
        flow.minimumLineSpacing = margin
        
        self.view.backgroundColor = Helper.UIColorFromRGB(0xf8f8fc)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        hidingNavBarManager?.viewWillAppear(animated)
        
        if (category.name == "All") {
            recipes = category.fetchAllRecipes()
        }
        else {
            recipes = category.fetchRecipes()
        }
        
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        hidingNavBarManager?.viewDidLayoutSubviews()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        hidingNavBarManager?.viewWillDisappear(animated)
    }
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        
        return true
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
        cell.setCell(recipe.name, image: recipe.getImage())
        
        return cell as UICollectionViewCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedIndexPath = indexPath
        
        let recipe: Recipe! = self.recipes[indexPath.row]

        let recipeViewController = RecipeViewController()
        recipeViewController.recipe = recipe
        recipeViewController.delegate = self
        
        self.navigationController?.pushViewController(recipeViewController, animated: true)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                                   sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //20 on each side plus 20 spacing in between items = 60
        let w = UIScreen.mainScreen().bounds.size.width - margin * 3
        
        //w 153, h 201
        
        return CGSize(width: w/2, height: w/2 * 201/154)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // MARK: Actions
    
    func addTapped() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("EditRecipeViewController") as! EditRecipeViewController
        vc.category = category
        
        let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
        
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }
    
    //MARK: RecipeViewControllerDelegate
    
    func didDeleteRecipe(sender: RecipeViewController) {
        if (self.selectedIndexPath != nil) {
            self.recipes.removeAtIndex(selectedIndexPath!.row)
            self.collectionView.deleteItemsAtIndexPaths([selectedIndexPath!])
            self.collectionView.reloadItemsAtIndexPaths([selectedIndexPath!])
//            self.collectionView.reloadData()
        }
    }
}
