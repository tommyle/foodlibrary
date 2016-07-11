//
//  BrowserViewController.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-05.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit
import DZNWebViewController

class BrowserViewController: UIViewController {
    
    var nav: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Parser.parse("http://allrecipes.com/recipe/127565/steak-on-a-stick/?internalSource=previously%20viewed&referringContentType=home%20page")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func broswerButtonPressed(sender: AnyObject) {
        
        let url = NSURL (string: "http://www.allrecipes.com")
        let vc = WebViewController.init(URL: url)
        vc.supportedWebNavigationTools = DZNWebNavigationTools.None
        vc.supportedWebActions = DZNsupportedWebActions.DZNWebActionNone
        vc.showLoadingProgress = true
        vc.allowHistory = true
        vc.hideBarsWithGestures = false
        vc.showPageTitleAndURL = false
        
//        self.nav = UINavigationController.init(rootViewController: vc)
        
        self.navigationController?.pushViewController(vc, animated: true)
//        self.presentViewController(self.nav, animated: true, completion: nil)
    }
}
