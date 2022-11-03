//
//  IngridientCollectionViewCell.swift
//  Spoonacular
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit
import SDWebImage

final class IngridientCollectionViewCell: UICollectionViewCell {
  static var identifier: String { String(describing: self) }
  
  private let baseImageUrlString = "https://spoonacular.com/cdn/ingredients_100x100"
  @IBOutlet private weak var ingridientImageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var amountLabel: UILabel!
  
  func configure(with ingridient: Ingridient) {
    ingridientImageView.sd_setImage(
      with: URL(string: "\(baseImageUrlString)/\(ingridient.image)")
    )
    titleLabel.text = ingridient.name.capitalized
    amountLabel.text = quantity(from: ingridient.amount, unit: ingridient.unit)
  }
  
  private func quantity(from amount: Double, unit: String) -> String {
    if let whole = Int(exactly: amount) {
      return "\(whole) \(unit)"
    } else {
      return "\(String(format: "%.1f",amount)) \(unit)"
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    ingridientImageView.sd_cancelCurrentImageLoad()
  }
}
