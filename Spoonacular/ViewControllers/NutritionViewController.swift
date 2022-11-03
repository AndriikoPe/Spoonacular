//
//  NutritionViewController.swift
//  Spoonacular
//
//  Created by Пермяков Андрей on 04.11.2022.
//

import UIKit

final class NutritionViewController: UITableViewController, Storyboardable {
  var recipeName = ""
  private var pairs = [(key: String, value: String)]() {
    didSet { tableView.reloadData() }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchNutrition()
  }
  
  private func fetchNutrition() {
    Task {
      if let nutrition = await GuessNutritionResults()
        .guessNutrition(text: recipeName) {
        DispatchQueue.main.async { [weak self] in
          self?.generatePairs(from: nutrition)
        }
      } else {
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(
            title: "Something went wrong",
            message: "Could not fetch nutritions"
          )
        }
      }
    }
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
  
  private func generatePairs(from results: GuessNutritionResults) {
    pairs = [
      ("calories", "\(results.calories.value) \(results.calories.unit)"),
      ("fat" , "\(results.fat.value) \(results.fat.unit)"),
      ("protein", "\(results.protein.value) \(results.protein.unit)"),
      ("carbs", "\(results.carbs.value) \(results.carbs.unit)")
    ]
  }
}
