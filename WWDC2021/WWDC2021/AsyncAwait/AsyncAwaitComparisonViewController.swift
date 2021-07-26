//
//  AsyncAwaitComparisonViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 24/7/21.
//

import UIKit
import SwiftUI

struct AsyncAwaitComparisonViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AsyncAwaitComparisonViewController {
        return AsyncAwaitComparisonViewController()
    }

    func updateUIViewController(_ uiViewController: AsyncAwaitComparisonViewController, context: Context) {
        // do nothing
    }
}

class AsyncAwaitComparisonViewController: UIViewController {
    private let viewModel = AsyncAwaitComparisonViewModel()

    var oldJSONButton: UIButton!
    var newJSONButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
}

extension AsyncAwaitComparisonViewController {
    private func setupViewController() {
        setupOldJSONButton()
        setupNewJSONButton()
        
        setupConstraints()
    }

    private func setupOldJSONButton() {
        let primaryAction = UIAction(title: "Old JSON") { [weak self] _ in
            guard let self = self else { return }

            self.oldJSONButtonClicked()
        }

        var configuration = UIButton.Configuration.tinted()
        configuration.buttonSize = .large
        configuration.image = UIImage(systemName: "icloud")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10.0

        oldJSONButton = UIButton(configuration: configuration, primaryAction: primaryAction)
    }

    private func setupNewJSONButton() {
        let primaryAction = UIAction(title: "New JSON") { [weak self] _ in
            guard let self = self else { return }

            Task {
                await self.newJSONButtonClicked()
            }
        }

        var configuration = UIButton.Configuration.tinted()
        configuration.buttonSize = .large
        configuration.image = UIImage(systemName: "icloud.fill")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10.0

        newJSONButton = UIButton(configuration: configuration, primaryAction: primaryAction)
    }

    private func setupConstraints() {
        if oldJSONButton != nil {
            view.addSubview(oldJSONButton)

            let constraints = [
                oldJSONButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
                oldJSONButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            oldJSONButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate(constraints)
        }

        if newJSONButton != nil {
            view.addSubview(newJSONButton)

            let constraints = [
                newJSONButton.topAnchor.constraint(equalTo: oldJSONButton.bottomAnchor, constant: 20.0),
                newJSONButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            newJSONButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate(constraints)
        }
    }
}

extension AsyncAwaitComparisonViewController {
    private func oldJSONButtonClicked() {
        viewModel.oldGetJSON { jsonString, error in
            if let error = error {
                switch error {
                case AsyncAwaitComparisonViewModel.Errors.httpResponseError:
                    break

                case AsyncAwaitComparisonViewModel.Errors.otherGenericError:
                    break

                default:
                    break
                }
            } else if let jsonString = jsonString {
                DispatchQueue.main.async {
                    self.showAlert(text: jsonString)
                }
            }
        }
    }

    private func newJSONButtonClicked() async {
        do {
            if let jsonString = try await viewModel.newGetJSON() {
                DispatchQueue.main.async {
                    self.showAlert(text: jsonString)
                }
            }
        } catch AsyncAwaitComparisonViewModel.Errors.urlEncodingError {
            
        } catch AsyncAwaitComparisonViewModel.Errors.httpResponseError {

        } catch AsyncAwaitComparisonViewModel.Errors.dataEncodingError {

        } catch {

        }
    }

    private func showAlert(text: String) {
        let okAction = UIAlertAction(title: "OK", style: .default)

        let alertController = UIAlertController(title: "Hello Team", message: text, preferredStyle: .alert)
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
}
