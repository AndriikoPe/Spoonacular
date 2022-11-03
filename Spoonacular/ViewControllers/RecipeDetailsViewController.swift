//
//  RecipeDetailsViewController.swift
//  Spoonacular
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit
import SDWebImage

final class RecipeDetailsViewController: UIViewController, Storyboardable {
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var dishImageView: UIImageView!
  @IBOutlet private weak var ingridientsCollectionView: UICollectionView!
  @IBOutlet private weak var textView: UITextView!
  
  var recipe: Recipe!
  private var recipeDetails: GetRecipeResults? {
    didSet { setupSubviews() }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchDetails()
  }
  
  private func fetchDetails() {
    Task {
      if let result = await GetRecipeResults()
        .getRecipe(id: String(recipe.id)) {
        DispatchQueue.main.async { [weak self] in
          self?.recipeDetails = result
        }
      } else {
        DispatchQueue.main.async { [weak self] in
          self?.showAlert(
            title: "Error",
            message: "Could not find details for this recipe"
          )
        }
      }
    }
  }
  
  private func setupSubviews() {
    guard let recipeDetails else { return }
    ingridientsCollectionView.dataSource = self
    titleLabel.text = recipeDetails.title.capitalized
    if let imageName = recipeDetails.image {
      dishImageView.sd_setImage(with: URL(string: imageName))
    } else {
      dishImageView.isHidden = true
    }
    textView.text = recipeDetails.instructions
  }
  
  @IBAction private func presentCuisineTapped(_ sender: UIButton) {
    let cuisineVC = CuisineViewController.instantiate()
    cuisineVC.modalPresentationStyle = .popover
    cuisineVC.presentationController?.delegate = self
    cuisineVC.popoverPresentationController?.sourceView = sender
    cuisineVC.recipeDetails = recipeDetails
    
    present(cuisineVC, animated: true)
  }
}

extension RecipeDetailsViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int { recipeDetails?.extendedIngredients.count ?? 0 }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: IngridientCollectionViewCell.identifier,
      for: indexPath
    ) as! IngridientCollectionViewCell
    cell.configure(with: recipeDetails!.extendedIngredients[indexPath.item])
    
    return cell
  }
}
