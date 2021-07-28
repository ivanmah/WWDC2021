//
//  ApplePayViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 25/7/21.
//

import PassKit
import SwiftUI
import UIKit

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

    var paymentButton: PKPaymentButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()

        viewModel.addToShoppingCart(item: ApplePayItem(name: "Tickets", price: "25.00"))
        viewModel.addToShoppingCart(item: ApplePayItem(name: "Shirt", price: "89.00"))
    }
}

extension ApplePayViewController {
    private func setupViewController() {
        setupPaymentButton()
        
        setupConstraints()
    }

    private func setupPaymentButton() {
        let applePayStatus = viewModel.applePayStatus()

        if applePayStatus.canMakePayments || applePayStatus.canSetupCards {
            paymentButton = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)
            paymentButton.addTarget(self, action: #selector(paymentButtonClicked), for: .touchUpInside)
        }
    }

    private func setupConstraints() {
        if paymentButton != nil {
            view.addSubview(paymentButton)

            let constraints = [
                paymentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
                paymentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
                paymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
                paymentButton.heightAnchor.constraint(equalToConstant: 44.0),
            ]
            paymentButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate(constraints)
        }
    }
}

extension ApplePayViewController {
    @objc
    private func paymentButtonClicked() {
        viewModel.startPayment()
    }
}
