//
//  ButtonMainView.swift
//  ButtonMainView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct ButtonMainView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            NavigationLink("Button Comparison") {
                ButtonComparisonViewControllerRepresentable()
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
    }
}

struct ButtonMainView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMainView()
    }
}
