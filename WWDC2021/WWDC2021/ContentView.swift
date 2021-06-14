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
                NavigationLink("Click Me", destination: {
                    FirstViewControllerRepresentable()
                        .navigationTitle("First View Controller")
                })
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
