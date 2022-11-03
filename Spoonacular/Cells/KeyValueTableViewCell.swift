//
//  RecipeDetailsTableViewCell.swift
//  Spoonacular
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit

final class KeyValueTableViewCell: UITableViewCell {
  static var identifier: String { String(describing: self) }
  
  @IBOutlet private weak var keyLabel: UILabel!
  @IBOutlet private weak var valueLabel: UILabel!
  
  func configure(with pair: (key: String, value: String)) {
    keyLabel.text = pair.key
    valueLabel.text = pair.value
  }
}
