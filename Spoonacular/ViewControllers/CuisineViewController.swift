//
//  CuisineViewController.swift
//  Spoonacular
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit

final class CuisineViewController: UITableViewController, Storyboardable {
  @IBOutlet private weak var titleLabel: UILabel!
  var recipeDetails: GetRecipeResults!
  private var pairs = [(key: String, value: String)]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchCuisine()
    generatePairs()
  }

  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int { pairs.count }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: KeyValueTableViewCell.identifier,
      for: indexPath
    ) as! KeyValueTableViewCell
    cell.configure(with: pairs[indexPath.item])
    
    return cell
  }
  
  private func fetchCuisine() {
    Task {
      if let cuisine = await ClassifyCuisineResult()
        .classifyCuisine(
          text: recipeDetails.title,
          ingredientList: recipeDetails
            .extendedIngredients
            .map { $0.name }
            .joined(separator: " ")
        ) {
        DispatchQueue.main.async { [titleLabel] in
          titleLabel?.text = "\(cuisine.cuisine) cuisine"
        }
      } else {
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(
            title: "Something went wrong",
            message: "Could not fetch cuisine"
          )
        }
      }
    }
  }
  
  private func generatePairs() {
    pairs = [
      ("Vegetarian", recipeDetails.vegetarian ? "Yes" : "No"),
      ("Vegan", recipeDetails.vegan ? "Yes" : "No"),
      ("GlutenFree", recipeDetails.glutenFree ? "Yes" : "No"),
      ("Dairy-free", recipeDetails.dairyFree ? "Yes" : "No"),
      ("Very healthy", recipeDetails.veryHealthy ? "Yes" : "No"),
      ("Cheap", recipeDetails.cheap ? "Yes" : "No"),
      ("Health score", String(recipeDetails.healthScore)),
      ("Price per serving", String(recipeDetails.pricePerServing))
    ]
  }
}
