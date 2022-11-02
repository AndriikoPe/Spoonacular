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
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "c83ea34ffamshc6b88199308346ap1580f4jsn5bfc243a7894",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        let networkService = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/", headers: headers)

        Task {
            let data = try await networkService.perform(.get, .guess, GuessInstruction("Pork roast with green beans"))
            print(try! JSONSerialization.jsonObject(with: data!))
        }
        
        do {
            let networkService = try Network<RecipesEndpoint>(
                "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/",
                headers: headers
            )

            Task {
                let data = try? await networkService.perform(.post, .classify, ClassifyInstruction("Pork roast with green beans","3 oz pork shoulder"))

                print(try! JSONSerialization.jsonObject(with: data!))
            }
        } catch {
            print(error)
        }
    }


}

