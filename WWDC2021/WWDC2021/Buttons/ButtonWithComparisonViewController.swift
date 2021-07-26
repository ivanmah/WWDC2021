//
//  ButtonWithComparisonViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

struct ButtonWithComparisonViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ButtonWithComparisonViewController {
        return ButtonWithComparisonViewController()
    }

    func updateUIViewController(_ uiViewController: ButtonWithComparisonViewController, context: Context) {
        // do nothing
    }
}

class ButtonWithComparisonViewController: UIViewController {
    var oldButton: UIButton!
    var newButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ButtonWithComparisonViewController {
    private func setupViewController() {
        setupOldButton()
        setupNewButton()
        
        setConstraints()
    }

    private func setupOldButton() {
        oldButton = UIButton(type: .system)
        oldButton.backgroundColor = .systemBlue
        oldButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        oldButton.setTitle(String(localized: "Old UIButton"), for: [])
        oldButton.setTitleColor(.white, for: [])
        oldButton.layer.cornerRadius = 10.0
    }

    private func setupNewButton() {
        newButton = UIButton(type: .system)
        newButton.configuration = .filled()
        newButton.setTitle(String(localized: "New UIButton"), for: [])
    }

    private func setConstraints() {
        if oldButton != nil {
            view.addSubview(oldButton)

            let constraints = [
                oldButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
                oldButton.heightAnchor.constraint(equalToConstant: 44.0),
                oldButton.widthAnchor.constraint(equalToConstant: 200.0),
                oldButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            oldButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate(constraints)
        }

        if newButton != nil {
            view.addSubview(newButton)

            let constraints = [
                newButton.topAnchor.constraint(equalTo: oldButton.bottomAnchor, constant: 20.0),
                newButton.heightAnchor.constraint(equalToConstant: 44.0),
                newButton.widthAnchor.constraint(equalToConstant: 200.0),
                newButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            newButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate(constraints)
        }
    }
}
