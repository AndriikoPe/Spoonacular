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
                let result = await ClassifyCuisineResult().classifyCuisine(text: "3 oz pork shoulder", ingredientList: "Pork roast with green beans")
                print(result)
            }
        
    }


}

