//
//  ButtonsContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import SwiftUI

struct ButtonsContentView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            NavigationLink("Button Comparison") {
                ButtonWithComparisonViewControllerRepresentable()
                    .navigationTitle("Comparison")
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("Button with Configuration") {
                ButtonWithConfigurationViewControllerRepresentable()
                    .navigationTitle("Configuration")
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("Button with ConfigurationUpdateHandler") {
                ButtonWithConfigurationUpdateHandlerViewControllerRepresentable()
                    .navigationTitle("ConfigurationUpdateHandler")
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("Button with UIAction") {
                ButtonWithUIActionViewControllerRepresentable()
                    .navigationTitle("UIAction")
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("Button with Toggle") {
                ButtonWithToggleViewControllerRepresentable()
                    .navigationTitle("Toggle")
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("Button with Popup") {
                ButtonWithPopupViewControllerRepresentable()
                    .navigationTitle("Popup")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationTitle("Buttons")
    }
}

struct ButtonsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
