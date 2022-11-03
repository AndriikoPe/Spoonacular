//
//  UIViewController+Extensions.swift
//  Spoonacular
//
//  Created by Пермяков Андрей on 04.11.2022.
//

import UIKit

extension UIViewController: UIPopoverPresentationControllerDelegate {
  public func adaptivePresentationStyle(
    for controller: UIPresentationController
  ) -> UIModalPresentationStyle { .none }
}

extension UIViewController {
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    let action = UIAlertAction(title: "Ok", style: .default)
    alert.addAction(action)
    present(alert, animated: true)
  }
}
