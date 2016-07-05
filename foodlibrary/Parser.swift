//
//  Parser.swift
//  foodlibrary
//
//  Created by Tommy Le on 2016-07-04.
//  Copyright © 2016 Tommy Le. All rights reserved.
//

import UIKit
import Fuzi

class Parser: NSObject {

    static func parse(recipeURL:String) {
        //let myURLString = "http://allrecipes.com/recipe/14186/"
        
        if let myURL = NSURL(string: recipeURL) {
            
            do {
                let myHTMLString = try String(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
                
                let doc = try HTMLDocument(string: myHTMLString, encoding: NSUTF8StringEncoding)
                
                //image
                if let recipeImagePath = doc.firstChild(xpath: "//img[@class=\"rec-photo\"]") {
                    if (recipeImagePath.attr("src") != nil) {
                        print(recipeImagePath.attr("src")!)
                    }
                }
                
                //recipe title
                if let recipeTitle = doc.firstChild(xpath: "//img[@class=\"rec-photo\"]") {
                    if (recipeTitle.attr("title") != nil) {
                        print(recipeTitle.attr("title")!)
                    }
                }
                
                //prep time
                if let prepTimeUnit = doc.firstChild(xpath: "//time[@itemprop=\"prepTime\"]") {
                    if (prepTimeUnit.attr("datetime") != nil) {
                        print(prepTimeUnit.attr("datetime")!)
                    }
                }
                
                //cook time
                if let cookTime = doc.firstChild(xpath: "//time[@itemprop=\"cookTime\"]") {
                    if (cookTime.attr("datetime") != nil) {
                        print(cookTime.attr("datetime")!)
                    }
                }
                
                let ingredientSet:XPathNodeSet = doc.xpath("//span[@itemprop=\"ingredients\"]/text()")
                for i in ingredientSet {
                    print(i)
                }
                
                let instructionSet:XPathNodeSet = doc.xpath("//span[@class=\"recipe-directions__list--item\"]/text()")
                for i in instructionSet {
                    print(i)
                }
                
            } catch {
                print("Error : \(error)")
            }
        } else {
            print("Error: \(recipeURL) invalid URL?")
        }
    }
}