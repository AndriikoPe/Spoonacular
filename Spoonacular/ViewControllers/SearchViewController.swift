//
//  ViewController.swift
//  Spoonacular
//
//  Created by Bohdan on 01.11.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    private var recipes = [Recipe]() {
        didSet { tableView.reloadData() }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegates()
    }
    
    private func assignDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func showDetails(for recipe: Recipe) {
        let detailsVC = RecipeDetailsViewController.instantiate()
        detailsVC.recipe = recipe
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    private func search(_ text: String) {
        Task {
            if let recipes = await SearchRecipeResults()
                .searchRecipe(text: text) {
                DispatchQueue.main.async { [weak self] in self?.recipes = recipes.results }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.showAlert(
                        title: "Try other query",
                        message: "Could not find recipes for this query"
                    )
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetails(for: recipes[indexPath.item])
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { recipes.count }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RecipeTableViewCell.identifier,
            for: indexPath
        ) as! RecipeTableViewCell
        cell.configure(with: recipes[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text, !text.isEmpty {
            search(text)
        }
    }
}

extension SearchViewController: RecipeNutritionDelegate {
    func showNutrition(for recipe: Recipe, _ sender: UIButton) {
        let nutritionVC = NutritionViewController.instantiate()
        nutritionVC.modalPresentationStyle = .popover
        nutritionVC.presentationController?.delegate = self
        nutritionVC.popoverPresentationController?.sourceView = sender
        nutritionVC.recipeName = recipe.title
        
        present(nutritionVC, animated: true)
    }
}
