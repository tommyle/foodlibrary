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

    static func parse(recipeURL:String) -> Recipe? {
        //let myURLString = "http://allrecipes.com/recipe/14186/"
        
        var recipe = Recipe.createEntity() as? Recipe

        if let myURL = NSURL(string: recipeURL) {
            
            do {
                let myHTMLString = try String(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
                
                let doc = try HTMLDocument(string: myHTMLString, encoding: NSUTF8StringEncoding)
                
                //image
                if let recipeImagePath = doc.firstChild(xpath: "//img[@class=\"rec-photo\"]") {
                    if (recipeImagePath.attr("src") != nil) {
                        let remoteImage = (recipeImagePath.attr("src")!)
                        
                        let image = UIImage(data: NSData(contentsOfURL: NSURL(string: remoteImage)!)!)
                        ImageSaver.saveImageToDisk(image!, andToRecipe: recipe!)
                    }
                }
                
                //recipe title
                if let recipeTitle = doc.firstChild(xpath: "//img[@class=\"rec-photo\"]") {
                    if (recipeTitle.attr("title") != nil) {
                        print(recipeTitle.attr("title")!)
                        recipe?.name = recipeTitle.attr("title")!
                    }
                }
                
                //prep time
                if let prepTimeUnit = doc.firstChild(xpath: "//time[@itemprop=\"prepTime\"]") {
                    if (prepTimeUnit.attr("datetime") != nil) {
                        print(prepTimeUnit.attr("datetime")!)
                        recipe?.prepTime = NSDate()
                    }
                }
                
                //cook time
                if let cookTime = doc.firstChild(xpath: "//time[@itemprop=\"cookTime\"]") {
                    if (cookTime.attr("datetime") != nil) {
                        print(cookTime.attr("datetime")!)
                        recipe?.cookTime = NSDate()
                    }
                }
                
                let ingredients: NSMutableOrderedSet! = recipe!.mutableOrderedSetValueForKey("ingredients")
                
                let ingredientSet:XPathNodeSet = doc.xpath("//span[@itemprop=\"ingredients\"]/text()")
                for i in ingredientSet {
                    let ingredient: Ingredient!
                    ingredient = Ingredient.createEntity() as! Ingredient
                    ingredient.name = i.stringValue
                    ingredients.addObject(ingredient)
                }
                
                let instructions: NSMutableOrderedSet! = recipe!.mutableOrderedSetValueForKey("instructions")
                
                let instructionSet:XPathNodeSet = doc.xpath("//span[@class=\"recipe-directions__list--item\"]/text()")
                for i in instructionSet {
                    let instruction: Instruction!
                    instruction = Instruction.createEntity() as! Instruction
                    instruction.text = i.stringValue
                    instructions.addObject(instruction)
                }
                
            } catch {
                print("Error : \(error)")
                recipe = nil
            }
        } else {
            print("Error: \(recipeURL) invalid URL?")
            recipe = nil
        }
        
        return recipe
    }
}