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
                NavigationLink("What's New In UIButton") {
                    ButtonsContentView()
                }

                NavigationLink("SwiftUI") {
                    SwiftUIContentView()
                }

                NavigationLink("Changes in Foundation") {
                    FoundationContentView()
                }

                NavigationLink("Swift 5.5: Async/Await") {
                    AsyncAwaitContentView()
                }
            }
            .navigationTitle("WWDC \(ColumnBreakpoint().parseArray(values: ["1", "2"]).count)021 Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}

