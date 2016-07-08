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

class WebViewController: DZNWebViewController, MEVFloatingButtonDelegate {

    var hidingNavBarManager: HidingNavigationBarManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.webView != nil) {
//            hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: self.webView.scrollView)
            
//            if let tabBar = navigationController?.tabBarController?.tabBar {
//                hidingNavBarManager?.manageBottomBar(tabBar)
//            }
            let button = MEVFloatingButton()
            
            button.animationType = MEVFloatingButtonAnimation.MEVFloatingButtonAnimationFromBottom
            button.displayMode =  MEVFloatingButtonDisplayMode.WhenScrolling
            button.position = MEVFloatingButtonPosition.BottomCenter
            button.image = UIImage(named: "Preparations")
//            button.imageColor = UIColor.redColor()
//            button.backgroundColor = UIColor.grayColor()
//            button.outlineColor = UIColor.darkGrayColor()
            button.outlineWidth = 0.0
            button.imagePadding = 0.0
            button.horizontalOffset = 0.0
            button.verticalOffset = 0.0
            button.rounded = true
            
            self.webView.scrollView.setFloatingButtonView(button)
            //        button.delegate = self
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func presentActivityController(sender: AnyObject!) {
        
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
    
    override func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        
        return true
    }
    
    ///- (void)presentActivityController:(id)sender;

}
