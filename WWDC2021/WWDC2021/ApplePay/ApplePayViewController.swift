//
//  ApplePayViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 25/7/21.
//

import PassKit
import SwiftUI
import UIKit

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
    private let disposeBag = DisposeBag()
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
        paymentButton = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)
        paymentButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else { return }

            self.viewModel.startPayment()
        }.disposed(by: disposeBag)
    }

    private func setupConstraints() {
        if paymentButton != nil {
            view.addSubview(paymentButton)

            paymentButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(100.0)
                make.leading.equalToSuperview().offset(20.0)
                make.trailing.equalToSuperview().offset(-20.0)
                make.height.equalTo(44.0)
            }
        }
    }
}
