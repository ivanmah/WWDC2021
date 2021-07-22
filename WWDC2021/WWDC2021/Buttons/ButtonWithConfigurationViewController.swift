//
//  ButtonWithConfigurationViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

import SnapKit

struct ButtonWithConfigurationViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ButtonWithConfigurationViewController {
        return ButtonWithConfigurationViewController()
    }

    func updateUIViewController(_ uiViewController: ButtonWithConfigurationViewController, context: Context) {
        // do nothing
    }
}

class ButtonWithConfigurationViewController: UIViewController {
    var firstButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ButtonWithConfigurationViewController {
    private func setupViewController() {
        setupFirstButton()

        setupConstraints()
    }

    private func setupFirstButton() {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Add to Cart"
        configuration.image = UIImage(systemName: "cart.badge.plus")
        configuration.imagePadding = 10.0
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule

        firstButton = UIButton(configuration: configuration)
    }

    private func setupConstraints() {
        if firstButton != nil {
            view.addSubview(firstButton)

            firstButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(100.0)
                make.centerX.equalToSuperview()
            }
        }
    }
}
