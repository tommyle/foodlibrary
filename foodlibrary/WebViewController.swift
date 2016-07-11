//
//  WebViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-05.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit
import DZNWebViewController
import PKHUD
import HidingNavigationBar
import MEVFloatingButton

class WebViewController: DZNWebViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    var hidingNavBarManager: HidingNavigationBarManager?
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(saveTapped))
        
        /*
        let backButton: UIButton = UIButton()
        backButton.setImage(UIImage(named: "backward"), forState: .Normal)
        backButton.frame = CGRectMake(0, 0, 30, 30)
//        searchButton.addTarget(self, action: #selector(saveTapped))", forControlEvents: .TouchUpInside)
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(customView: backButton), animated: true)
        */
        
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        
//        let searchImage = UIImage(named: "backward")!
        let saveImage   = UIImage(named: "Download")!
        
//        let searchButton = UIBarButtonItem(image: searchImage,  style: .Plain, target: self, action: #selector(searchButtonPressed))
        let saveButton = UIBarButtonItem(image: saveImage,  style: .Plain, target: self, action: #selector(saveButtonPressed))
        
        navigationItem.rightBarButtonItems = [saveButton]
        
        searchController.searchBar.searchBarStyle = UISearchBarStyle.Minimal;
        self.navigationItem.titleView = searchController.searchBar

        
        if (self.webView != nil) {
            hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: self.webView.scrollView)
            
//            if let tabBar = navigationController?.tabBarController?.tabBar {
//                hidingNavBarManager?.manageBottomBar(tabBar)
//            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        hidingNavBarManager?.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        hidingNavBarManager?.viewDidLayoutSubviews()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        hidingNavBarManager?.viewWillDisappear(animated)
    }
    
    override func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        
        return true
    }
    
    func searchButtonPressed() {
        
    }
    
    func saveButtonPressed() {
        if (self.webView.URL?.absoluteString == nil) {
            return
        }
        
        HUD.show(.Progress)
        let recipe = Parser.parse((self.webView.URL?.absoluteString)!)
        
        if (recipe != nil) {
            HUD.flash(.Success, delay: 1.0)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("EditRecipeViewController") as! EditRecipeViewController
            vc.recipe = recipe
            
            let nav = UINavigationController.init(rootViewController: vc)
            self.navigationController!.presentViewController(nav, animated: true, completion: nil)
        }
        else {
            HUD.flash(.LabeledError(title: "Import Error", subtitle: ""), delay: 3.0)
        }
    }
    
    //MARK: UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchTerm = self.searchController.searchBar.text {
            
            if let escapedString = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) {
                
                if let url = NSURL(string: "http://allrecipes.com/search/results/?wt=" + escapedString + "&sort=re") {
                    
                    let request = NSURLRequest(URL: url)
                    self.webView.loadRequest(request)
                }
            }
        }
        
        self.searchController.active = false
    }

}
