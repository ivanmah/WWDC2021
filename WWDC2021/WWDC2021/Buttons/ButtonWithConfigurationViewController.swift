//
//  ButtonWithConfigurationViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import UIKit
import SwiftUI

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
    
    //configuration
    var grayButton: UIButton!
    var plainButton: UIButton!
    var filledButton: UIButton!
    var tinitedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension ButtonWithConfigurationViewController {
    private func setupViewController() {
        setupFirstButton()
        
        setupGrayButton()
        setupPlainButton()
        setupFilledButton()
        setupTintedButton()
        
        setupConstraints()
    }

    private func setupFirstButton() {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = String(localized: "Add to Cart")
        configuration.image = UIImage(systemName: "cart.badge.plus")
        configuration.imagePadding = 10.0
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule

        firstButton = UIButton(configuration: configuration)
    }
    
    private func setupGrayButton() {
        var configuration = UIButton.Configuration.gray()
        configuration.title = String(localized: "Gray")
        
        grayButton = UIButton(configuration: configuration)
    }
    
    private func setupPlainButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = String(localized: "Plain")
        
        plainButton = UIButton(configuration: configuration)
    }
    
    private func setupFilledButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.title = String(localized: "filled")
        
        filledButton = UIButton(configuration: configuration)
    }
    
    private func setupTintedButton() {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = String(localized: "Tinted")
        
        tinitedButton = UIButton(configuration: configuration)
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
        
        if grayButton != nil {
            view.addSubview(grayButton)
            
            let contraints = [
                grayButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0),
                grayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
            ]
            grayButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(contraints)
        }
        
        if filledButton != nil {
            view.addSubview(filledButton)
            
            let contraints = [
                filledButton.topAnchor.constraint(equalTo: grayButton.topAnchor),
                filledButton.leadingAnchor.constraint(equalTo: grayButton.trailingAnchor,constant: 20)
            ]
            
            filledButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(contraints)
        }
        
        if plainButton != nil {
            view.addSubview(plainButton)

            let constraints = [
                plainButton.topAnchor.constraint(equalTo: grayButton.topAnchor),
                plainButton.leadingAnchor.constraint(equalTo: filledButton.trailingAnchor,constant: 20)
            ]

            plainButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
        }
        
        if tinitedButton != nil {
            view.addSubview(tinitedButton)

            let constraints = [
                tinitedButton.topAnchor.constraint(equalTo: grayButton.topAnchor),
                tinitedButton.leadingAnchor.constraint(equalTo: plainButton.trailingAnchor, constant: 20)
            ]

            tinitedButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
        }
        
    }
}
