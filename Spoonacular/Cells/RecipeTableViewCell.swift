//
//  RecipeTableViewCell.swift
//  Spoonacular
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit
import SDWebImage

protocol RecipeNutritionDelegate: AnyObject {
    func showNutrition(for recipe: Recipe, _ sender: UIButton)
}

final class RecipeTableViewCell: UITableViewCell {
    static var identifier: String { String(describing: self) }
    
    weak var delegate: RecipeNutritionDelegate?
    
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeName: UILabel!
    private var recipe: Recipe!
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        recipeImageView.sd_setImage(with: URL(string: recipe.image))
        recipeName.text = recipe.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.sd_cancelCurrentImageLoad()
    }
    
    @IBAction private func infoTapped(_ sender: UIButton) {
        delegate?.showNutrition(for: recipe, sender)
    }
}
