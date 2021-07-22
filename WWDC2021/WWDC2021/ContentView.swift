//
//  ContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20.0) {
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
            .navigationTitle("WWDC 2021 Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
