//
//  ApplePayViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 25/7/21.
//

import UIKit
import SwiftUI

import RxCocoa
import RxSwift
import SnapKit

struct ApplePayViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ApplePayViewController {
        return ApplePayViewController()
    }

    func updateUIViewController(_ uiViewController: ApplePayViewController, context: Context) {
        // do nothing
    }
}

class ApplePayViewController: UIViewController {
    private let viewModel = ApplePayViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ApplePayViewController {
    private func setupViewController() {
        viewModel.addToShoppingCart(item: ApplePayItem(name: "Tickets", price: "25.00"))
        viewModel.addToShoppingCart(item: ApplePayItem(name: "Shirt", price: "89.00"))
        viewModel.startPayment()
    }
}
