//
//  ButtonWithPopup.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

import SnapKit

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
            UIAction(title: "First", handler: handler),
            UIAction(title: "Second", state: .on, handler: handler),
            UIMenu(title: "Others", children: [
                UIAction(title: "Third", handler: handler),
                UIAction(title: "Fourth", handler: handler),
                UIAction(title: "Fifth", handler: handler)
            ])
        ])
        firstButton.showsMenuAsPrimaryAction = true
        firstButton.changesSelectionAsPrimaryAction = true
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
