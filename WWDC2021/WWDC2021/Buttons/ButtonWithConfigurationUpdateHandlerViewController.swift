//
//  ButtonWithConfigurationUpdateHandlerViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

struct ButtonWithConfigurationUpdateHandlerViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ButtonWithConfigurationUpdateHandlerViewController {
        return ButtonWithConfigurationUpdateHandlerViewController()
    }

    func updateUIViewController(_ uiViewController: ButtonWithConfigurationUpdateHandlerViewController, context: Context) {
        // do nothing
    }
}

class ButtonWithConfigurationUpdateHandlerViewController: UIViewController {
    var firstButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ButtonWithConfigurationUpdateHandlerViewController {
    private func setupViewController() {
        setupFirstButton()

        setupConstraints()
    }

    private func setupFirstButton() {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = String(localized: "Add to Cart")
        configuration.image = UIImage(systemName: "cart.badge.plus")
        configuration.imagePadding = 10.0
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule

        firstButton = UIButton(configuration: configuration)
        firstButton.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.image = button.isHighlighted ? UIImage(systemName: "cart.fill.badge.plus") : UIImage(systemName: "cart.badge.plus")

            button.configuration = config
        }
    }

    private func setupConstraints() {
        if firstButton != nil {
            view.addSubview(firstButton)

            let constraints = [
                firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
                firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            firstButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate(constraints)
        }
    }
}
