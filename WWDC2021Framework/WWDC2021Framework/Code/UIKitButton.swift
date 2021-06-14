//
//  UIKitButton.swift
//  WWDC2021
//
//  Created by Ivan Mah on 14/6/21.
//

import Foundation
import UIKit

class UIKitButton {
    private let isCartBusy = true

    var signInButton: UIButton?
    var addToCartButton: UIButton?
    var addToCartButtonWithConfigurationUpdateHandler: UIButton?
    var largeButton: UIButton?
    var toggleButton: UIButton?
    var popupButton: UIButton?

    var itemQuantityDescription: String? {
        didSet {
            addToCartButtonWithConfigurationUpdateHandler?.setNeedsUpdateConfiguration()
        }
    }

    func createFirstButton() {
        let signInButton = UIButton(type: .system)
        signInButton.configuration = .filled()
        signInButton.setTitle("Sign In", for: [])
    }

    func createSecondButton() {
        var config = UIButton.Configuration.tinted()
        config.title = "Add to Cart"
        config.image = UIImage(systemName: "cart.badge.plus")
        config.imagePlacement = .trailing
        config.buttonSize = .large
        config.cornerStyle = .capsule

        addToCartButton = UIButton(configuration: config)
    }

    func createButtonWithConfigurationUpdateHandler() {
        addToCartButtonWithConfigurationUpdateHandler = UIButton(type: .system)
        addToCartButton?.configuration = .filled()
        addToCartButton?.setTitle("Add To Cart", for: [])

        addToCartButton?.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }

            var config = button.configuration
            config?.image = button.isHighlighted ? UIImage(systemName: "cart.fill.badge.plus") : UIImage(systemName: "cart.badge.plus")
            config?.subtitle = self.itemQuantityDescription

            button.configuration = config
        }
    }

    func createLargeButton() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.image = UIImage(systemName: "cart.fill")
        config.title = "Checkout"
        config.background.backgroundColor = .systemBlue

        largeButton = UIButton(configuration: config)

        largeButton?.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }

            var config = button.configuration
            config?.showsActivityIndicator = self.isCartBusy

            button.configuration = config
        }
    }

    func createToggleButton() {
        let stockToggleAction = UIAction(title: "In Stock Only") { [weak self] _ in
            guard let self = self else { return }

            self.toggleStock()
        }

        let toggleButton = UIButton(primaryAction: stockToggleAction)
        toggleButton.changesSelectionAsPrimaryAction = true
        toggleButton.isSelected = true
    }

    func createPopupButton() {
        let colorClosure = { [weak self] (action: UIAction) in
            guard let self = self else { return }

            self.updateColor(action.title)
        }

        let button = UIButton(primaryAction: nil)
        button.menu = UIMenu(children: [
            UIAction(title: "Bondi Blue", handler: colorClosure),
            UIAction(title: "Flower Power", state: .on, handler: colorClosure)
        ])

        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true

        updateColor(button.menu?.selectedElements.first?.title)

        // set selection via programmatically

        (button.menu?.children[selectedColorIndex()] as? UIAction)?.state = .on
    }

    func createMenu() {
        let sortClosure = { (action: UIAction) in }
        let refreshClosure = { (action: UIAction) in }
        let accountClosure = { (action: UIAction) in }

        let sortMenu = UIMenu(title: "Sort By", options: .singleSelection, children: [
            UIAction(title: "Title", handler: sortClosure),
            UIAction(title: "Date", handler: sortClosure),
            UIAction(title: "Size", handler: sortClosure)
        ])

        let topMenu = UIMenu(children: [
            UIAction(title: "Refresh", handler: refreshClosure),
            UIAction(title: "Account", handler: accountClosure),
            sortMenu
        ])

        let sortSelectionButton = UIBarButtonItem(primaryAction: nil, menu: topMenu)

        updateSorting(sortSelectionButton.menu?.selectedElements.first)
    }

    func updateItemQuantityDescription(itemQuantityDescription: String) {
        self.itemQuantityDescription = itemQuantityDescription
    }

    func setAddToCartButtonWithConfigurationUpdateHandlerBusyIndicator() {
        addToCartButtonWithConfigurationUpdateHandler?.configuration?.showsActivityIndicator = true
        addToCartButtonWithConfigurationUpdateHandler?.updateConfiguration()
    }

    func adjustAddToCartButtonWithConfigurationUpdateHandlerIconLayout() {
        addToCartButtonWithConfigurationUpdateHandler?.configuration?.contentInsets.top = 5.0
        addToCartButtonWithConfigurationUpdateHandler?.configuration?.titlePadding = 10.0
        addToCartButtonWithConfigurationUpdateHandler?.configuration?.imagePadding = 20.0
        addToCartButtonWithConfigurationUpdateHandler?.updateConfiguration()
    }
}

extension UIKitButton {
    private func toggleStock() {

    }

    private func updateColor(_ title: String?) {

    }

    private func selectedColorIndex() -> Int {
        return 0
    }

    private func updateSorting(_ menuItem: UIMenuElement?) {

    }
 }
