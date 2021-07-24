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
            VStack(alignment: .center, spacing: 20.0) {
                NavigationLink("Buttons", destination: ButtonMainView())
                NavigationLink("SwiftUI", destination: SwiftUIMainView())
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
