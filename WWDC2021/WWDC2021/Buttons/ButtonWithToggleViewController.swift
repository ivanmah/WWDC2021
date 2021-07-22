//
//  ButtonWithToggleViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

import SnapKit

struct ButtonWithToggleViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ButtonWithToggleViewController {
        return ButtonWithToggleViewController()
    }

    func updateUIViewController(_ uiViewController: ButtonWithToggleViewController, context: Context) {
        // do nothing
    }
}

class ButtonWithToggleViewController: UIViewController {
    private var isSelected = true

    var firstButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ButtonWithToggleViewController {
    private func setupViewController() {
        setupFirstButton()

        setupConstraints()
    }

    private func setupFirstButton() {
        let primaryAction = UIAction(title: "Toggle On") { _ in }

        firstButton = UIButton(primaryAction: primaryAction)
        firstButton.changesSelectionAsPrimaryAction = true
        firstButton.isSelected = true
    }

    private func setupConstraints() {
        if firstButton != nil {
            view.addSubview(firstButton)

            firstButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(20.0)
                make.centerX.equalToSuperview()
            }
        }
    }
}
