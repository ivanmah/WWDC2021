//
//  AsyncAwaitComparisonViewController.swift
//  WWDC2021
//
//  Created by Ivan Mah on 24/7/21.
//

import UIKit
import SwiftUI

import RxCocoa
import RxSwift
import SnapKit

struct AsyncAwaitComparisonViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AsyncAwaitComparisonViewController {
        return AsyncAwaitComparisonViewController()
    }

    func updateUIViewController(_ uiViewController: AsyncAwaitComparisonViewController, context: Context) {
        // do nothing
    }
}

class AsyncAwaitComparisonViewController: UIViewController {
    private let disposeBag = DisposeBag()
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
        var configuration = UIButton.Configuration.tinted()
        configuration.buttonSize = .large
        configuration.image = UIImage(systemName: "icloud")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10.0
        configuration.title = "Old JSON"

        oldJSONButton = UIButton(configuration: configuration)
        oldJSONButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else { return }

            self.oldJSONButtonClicked()
        }.disposed(by: disposeBag)
    }

    private func setupNewJSONButton() {
        var configuration = UIButton.Configuration.tinted()
        configuration.buttonSize = .large
        configuration.image = UIImage(systemName: "icloud.fill")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10.0
        configuration.title = "New JSON"

        newJSONButton = UIButton(configuration: configuration)
        newJSONButton.rx.tap.subscribe { [weak self] _ in
            guard let self = self else { return }

            Task.detached {
                await self.newJSONButtonClicked()
            }
        }.disposed(by: disposeBag)
    }

    private func setupConstraints() {
        if oldJSONButton != nil {
            view.addSubview(oldJSONButton)

            oldJSONButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(100.0)
                make.centerX.equalToSuperview()
            }
        }

        if newJSONButton != nil {
            view.addSubview(newJSONButton)

            newJSONButton.snp.remakeConstraints { make in
                make.top.equalTo(oldJSONButton.snp.bottom).offset(20.0)
                make.centerX.equalToSuperview()
            }
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
