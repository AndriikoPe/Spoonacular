//
//  JSONStructs.swift
//  Spoonacular
//
//  Created by Bohdan on 01.11.2022.
//

import Foundation


let headers = [
    "content-type": "application/x-www-form-urlencoded",
    "X-RapidAPI-Key": "c83ea34ffamshc6b88199308346ap1580f4jsn5bfc243a7894",
    "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
]


struct SearchRecipeResults: Codable {
    
    var results: [Recipe] = []
    var totalResults: Int = 0
    
    func searchRecipe(text: String) async -> SearchRecipeResults?{
        do{
            let networkService = try Network<RecipesEndpoint>(
                "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/",
                headers: headers
            )
            
            let data = try? await networkService.perform(.get, .search, RecipeSearchInstruction(text))
            
            let results = try JSONDecoder().decode(SearchRecipeResults.self, from: data!)
            
            return results
        } catch {
            print(error)
        }
        return nil
    }
}


struct Recipe: Codable {
    
    var id: Int
    var title: String
    var image: String
    
}


struct GetRecipeResults: Codable {
    
    var id: Int = 0
    var title: String = ""
    var image: String = ""
    var summary: String = ""
    var instructions: String = ""
    var extendedIngredients: [Ingridient] = []
    var sourceUrl: String = ""
    
    var vegetarian: Bool = false
    var vegan: Bool = false
    var glutenFree: Bool = false
    var dairyFree: Bool = false
    var veryHealthy: Bool = false
    var cheap: Bool = false
    var healthScore: Int = 0
    var sourceName: String = ""
    var pricePerServing: Double = 0.0
    
    
    
    func getRecipe(id: String) async -> GetRecipeResults?{
        do{
            let networkService = try Network<RecipesEndpoint>(
                "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/",
                headers: headers
            )
            
            let data = try? await networkService.perform(.get, .getRecipe, GetRecipeInstruction(id))
            
            let results = try JSONDecoder().decode(GetRecipeResults.self, from: data!)
            
            return results
        } catch {
            print(error)
        }
        return nil
    }
}

struct Ingridient: Codable {
    var id: Int
    var name: String
    var image: String
    var amount: Double
    var unit: String
}

struct GuessNutritionResults: Codable{
    
    var calories = Nutrition()
    var fat =  Nutrition()
    var protein = Nutrition()
    var carbs = Nutrition()
    
    func guessNutrition(text: String) async -> GuessNutritionResults?{
        do{
            let networkService = try Network<RecipesEndpoint>(
                "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/",
                headers: headers
            )
            
            let data = try? await networkService.perform(.get, .guess, GuessInstruction(text))
            
            let results = try JSONDecoder().decode(GuessNutritionResults.self, from: data!)
            
            return results
        } catch {
            print(error)
        }
        return nil
    }
}

struct Nutrition: Codable{
    var value: Int = 0
    var unit: String = ""
}

struct ClassifyCuisineResult: Codable {
    var cuisine: String = ""
    
    func classifyCuisine(text: String, ingredientList: String) async -> ClassifyCuisineResult?{
        do{
            let networkService = try Network<RecipesEndpoint>(
                "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/",
                headers: headers
            )
            
            let data = try? await networkService.perform(.post, .classify, ClassifyInstruction(text, ingredientList))
            
            let results = try JSONDecoder().decode(ClassifyCuisineResult.self, from: data!)
            
            return results
        } catch {
            print(error)
        }
        return nil
    }
}
