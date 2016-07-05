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

class WebViewController: DZNWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("EditRecipeViewController") as! EditRecipeViewController
            vc.recipe = recipe
            
            let nav = UINavigationController.init(rootViewController: vc)
            self.navigationController!.presentViewController(nav, animated: true, completion: nil)
        }
        
        HUD.flash(.Success, delay: 1.0)
    }
    
    ///- (void)presentActivityController:(id)sender;

}
