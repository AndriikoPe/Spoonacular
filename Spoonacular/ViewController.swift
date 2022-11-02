//
//  ViewController.swift
//  Spoonacular
//
//  Created by Bohdan on 01.11.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            Task {
                let result = await ClassifyCuisineResult().classifyCuisine(text: "Apple pie", ingredientList: "apples flour water sugar")
                print(result)
            }
        
    }


}

