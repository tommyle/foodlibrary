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
        
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Oxygen-Regular", size: 18)!]
        self.navigationController!.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.tintColor = Helper.UIColorFromRGB(0x9274ED)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = false
        
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
