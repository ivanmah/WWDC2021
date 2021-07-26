//
//  ButtonWithPopup.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

struct ButtonWithPopupViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ButtonWithPopupViewController {
        return ButtonWithPopupViewController()
    }

    func updateUIViewController(_ uiViewController: ButtonWithPopupViewController, context: Context) {
        // do nothing
    }
}

class ButtonWithPopupViewController: UIViewController {
    var firstButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ButtonWithPopupViewController {
    private func setupViewController() {
        setupFirstButton()

        setupConstraints()
    }

    private func setupFirstButton() {
        let handler = { (action: UIAction) in }

        var configuration = UIButton.Configuration.tinted()
        configuration.image = UIImage(systemName: "sun.max.fill")
        configuration.imagePadding = 10.0
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule

        firstButton = UIButton(configuration: configuration)
        firstButton.menu = UIMenu(children: [
            UIAction(title: String(localized: "First"), handler: handler),
            UIAction(title: String(localized: "Second"), state: .on, handler: handler),
            UIMenu(title: String(localized: "Others"), children: [
                UIAction(title: String(localized: "Third"), handler: handler),
                UIAction(title: String(localized: "Fourth"), handler: handler),
                UIAction(title: String(localized: "Fifth"), handler: handler)
            ])
        ])
        firstButton.showsMenuAsPrimaryAction = true
        firstButton.changesSelectionAsPrimaryAction = true
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
