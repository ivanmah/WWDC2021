//
//  AsyncAwaitContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 24/7/21.
//

import SwiftUI

struct AsyncAwaitContentView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            NavigationLink("AsyncAwait Comparison") {
                AsyncAwaitComparisonViewControllerRepresentable()
                    .navigationTitle("Comparison")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationTitle("AsyncAwait")
    }
}

struct AsyncAwaitContentView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
