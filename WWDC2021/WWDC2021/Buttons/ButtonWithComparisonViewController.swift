//
//  ButtonWithComparisonViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

import SnapKit

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
        oldButton.setTitle("Old UIButton", for: [])
        oldButton.setTitleColor(.white, for: [])
        oldButton.layer.cornerRadius = 10.0
    }

    private func setupNewButton() {
        newButton = UIButton(type: .system)
        newButton.configuration = .filled()
        newButton.setTitle("New UIButton", for: [])
    }

    private func setConstraints() {
        if oldButton != nil {
            view.addSubview(oldButton)

            oldButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(20.0)
                make.size.equalTo(CGSize(width: 200.0, height: 44.0))
                make.centerX.equalToSuperview()
            }
        }

        if newButton != nil {
            view.addSubview(newButton)

            newButton.snp.remakeConstraints { make in
                make.top.equalTo(oldButton.snp.bottom).offset(20.0)
                make.size.equalTo(CGSize(width: 200.0, height: 44.0))
                make.centerX.equalToSuperview()
            }
        }
    }
}
