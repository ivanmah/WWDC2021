//
//  FirstViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

import SnapKit

struct FirstViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FirstViewController {
        return FirstViewController()
    }

    func updateUIViewController(_ uiViewController: FirstViewController, context: Context) {
        // do nothing
    }
}

class FirstViewController: UIViewController {
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension FirstViewController {
    private func setupViewController() {

    }

    private func setupStackView() {
        stackView = UIStackView()
        
    }
}
