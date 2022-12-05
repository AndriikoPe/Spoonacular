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
            
            let data = try await networkService.perform(.get, .search, RecipeSearchInstruction(text))
            
            let results = try JSONDecoder().decode(SearchRecipeResults.self, from: data)
            
            return results
        } catch {
            print(error)
        }
        return nil
    }
  
  static let MockSearchResults =
  SearchRecipeResults(results: [Spoonacular.Recipe(id: 1089142, title: "Apple pie", image: "https://spoonacular.com/recipeImages/1089142-312x231.jpg"), Spoonacular.Recipe(id: 1135081, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/1135081-312x231.jpg"), Spoonacular.Recipe(id: 952363, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/952363-312x231.jpg"), Spoonacular.Recipe(id: 948638, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/948638-312x231.jpg"), Spoonacular.Recipe(id: 475541, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/475541-312x231.jpg"), Spoonacular.Recipe(id: 70262, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/70262-312x231.jpg"), Spoonacular.Recipe(id: 70280, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/70280-312x231.jpg"), Spoonacular.Recipe(id: 70285, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/70285-312x231.jpg"), Spoonacular.Recipe(id: 70353, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/70353-312x231.jpg"), Spoonacular.Recipe(id: 70362, title: "Apple Pie", image: "https://spoonacular.com/recipeImages/70362-312x231.jpg")], totalResults: 1351)
}


struct Recipe: Codable {
    
    var id: Int
    var title: String
    var image: String
    
}


struct GetRecipeResults: Codable {
    
    var id: Int = 0
    var title: String = ""
    var image: String? = ""
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
    
    static let mockResults = GetRecipeResults(id: 1089142, title: "Apple pie", image: "https://spoonacular.com/recipeImages/1089142-556x370.jpg", summary: "Forget going out to eat or ordering takeout every time you crave American food. Try making Apple pie at home. This lacto ovo vegetarian recipe serves 4 and costs <b>$1.13 per serving</b>. One portion of this dish contains about <b>8g of protein</b>, <b>30g of fat</b>, and a total of <b>591 calories</b>. If you have honey, cinnamon, cooking apples, and a few other ingredients on hand, you can make it. It works well as a dessert. From preparation to the plate, this recipe takes roughly <b>1 hour</b>. 1 person found this recipe to be delicious and satisfying. It is brought to you by BBC Good Food. With a spoonacular <b>score of 81%</b>, this dish is spectacular. Similar recipes are <a href=\"https://spoonacular.com/recipes/sugarless-apple-pie-sugarfree-pie-can-be-tasty-you-can-make-sugarfree-apple-pie-at-home-600070\">Sugarless Apple Pie – sugarfree pie can be tasty, you can make sugarfree apple pie at home</a>, <a href=\"https://spoonacular.com/recipes/baked-apple-pie-cookie-cups-with-apple-pie-mousse-506649\">Baked Apple Pie Cookie Cups with Apple Pie Mousse</a>, and <a href=\"https://spoonacular.com/recipes/stovetop-apple-pie-filling-and-over-18-apple-pie-678327\">Stovetop Apple Pie Filling and Over 18 Apple Pie</a>.", instructions: "Heat oven to 200C/180C fan/gas 6. To make the pastry, sift the flour into a large mixing bowl and add the butter or margarine. Using your fingers, mix together until the mixture resembles breadcrumbs.\nAdd about 3 tbsp cold water  1 tbsp at a time  to bind the mixture into a ball. Then wrap it in cling film and leave to chill in the fridge while you prepare the apples, or for 30 mins if you have time.\nWhile the pastry is chilling, core the apples, then cut into even-sized chunks so they all cook in the same amount of time. Put the apples into the pie dish, drizzle over the honey and add the cinnamon, mixed spice and about 2 tbsp water.\nRoll out the pastry on a floured work surface until it is large enough to cover the pie dish. Using the rolling pin, carefully lift the pastry and lay it over the top of the apple mixture. Carefully trim off the excess pastry (this can be rerolled and cut into shapes to decorate the pie crust if you like) and press the pastry edges onto the dish to create a seal.\nMake a small cut in the pastry so that the air can escape during cooking, then brush with beaten egg to glaze.\nBake the pie in the oven for 20-30 mins until the pastry is golden and sandy in appearance and the apple filling is bubbling and hot. Serve while still warm with crme frache, ice cream or natural yogurt.", extendedIngredients: [Spoonacular.Ingridient(id: 20081, name: "plain flour", image: "flour.png", amount: 225.0, unit: "g"), Spoonacular.Ingridient(id: 1001, name: "butter", image: "butter-sliced.jpg", amount: 140.0, unit: "g"), Spoonacular.Ingridient(id: 9003, name: "apples", image: "apple.jpg", amount: 3.0, unit: "large"), Spoonacular.Ingridient(id: 19296, name: "honey", image: "honey.png", amount: 2.0, unit: "tbsp"), Spoonacular.Ingridient(id: 2010, name: "cinnamon", image: "cinnamon.jpg", amount: 1.0, unit: "pinch"), Spoonacular.Ingridient(id: 1022035, name: "mixed spice", image: "ground-coriander.jpg", amount: 1.0, unit: "pinch"), Spoonacular.Ingridient(id: 1123, name: "egg", image: "egg.png", amount: 1.0, unit: ""), Spoonacular.Ingridient(id: 1001116, name: "natural yogurt", image: "plain-yogurt.jpg", amount: 1.0, unit: "serving")], sourceUrl: "https://www.bbcgoodfood.com/recipes/apple-pie", vegetarian: true, vegan: false, glutenFree: false, dairyFree: false, veryHealthy: false, cheap: false, healthScore: 4, sourceName: "BBC Good Food", pricePerServing: 112.51)
    
    func getRecipe(id: String) async -> GetRecipeResults?{
        do{
            let networkService = try Network<RecipesEndpoint>(
                "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/",
                headers: headers
            )
            
            let data = try await networkService.perform(.get, .getRecipe, GetRecipeInstruction(id))
            
            let results = try JSONDecoder().decode(GetRecipeResults.self, from: data)
            
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
            
            let data = try await networkService.perform(.get, .guess, GuessInstruction(text))
            
            let results = try JSONDecoder().decode(GuessNutritionResults.self, from: data)
            
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
            
            let data = try await networkService.perform(.post, .classify, ClassifyInstruction(text, ingredientList))
            
            let results = try JSONDecoder().decode(ClassifyCuisineResult.self, from: data)
            
            return results
        } catch {
            print(error)
        }
        return nil
    }
}
