//
//  ButtonWithUIActionViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import Combine
import UIKit
import SwiftUI

struct ButtonWithUIActionViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ButtonWithUIActionViewController {
        return ButtonWithUIActionViewController()
    }

    func updateUIViewController(_ uiViewController: ButtonWithUIActionViewController, context: Context) {
        // do nothing
    }
}

class ButtonWithUIActionViewController: UIViewController {
    private let timerDuration = 2

    private var count = 0
    private var currentTimerDuration = 0
    private var isBusy = false
    private var subscriptions = Set<AnyCancellable>()

    var firstButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ButtonWithUIActionViewController {
    private func setupViewController() {
        setupFirstButton()

        setupConstraints()
    }

    private func setupFirstButton() {
        let primaryAction = UIAction(title: "") { [weak self] _ in
            guard let self = self else { return }

            self.incrementCart()
        }

        var configuration = UIButton.Configuration.tinted()
        configuration.title = String(localized: "Add to Cart")
        configuration.titlePadding = 10.0
        configuration.image = UIImage(systemName: "cart.badge.plus")
        configuration.imagePadding = 10.0
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule

        firstButton = UIButton(configuration: configuration, primaryAction: primaryAction)
        firstButton.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }

            var config = button.configuration
            config?.image = self.count > 0 ? UIImage(systemName: "cart.fill.badge.plus") : UIImage(systemName: "cart.badge.plus")
            config?.showsActivityIndicator = self.isBusy

            if self.count > 0 {
                config?.subtitle = String(localized: "\(self.count) item(s) added to cart")
            }

            button.configuration = config
        }
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

extension ButtonWithUIActionViewController {
    private func incrementCart() {
        isBusy = true

        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.currentTimerDuration += 1

                if self.currentTimerDuration > self.timerDuration {
                    self.count += 1
                    self.currentTimerDuration = 0
                    self.isBusy = false
                    self.firstButton.setNeedsUpdateConfiguration()

                    self.subscriptions.removeAll()
                }
            }
            .store(in: &subscriptions)
    }
}
