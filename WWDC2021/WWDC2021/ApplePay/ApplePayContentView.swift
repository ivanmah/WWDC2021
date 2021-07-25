//
//  ApplePayContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 25/7/21.
//

import SwiftUI

struct ApplePayContentView: View {
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            NavigationLink("Start Apple Pay") {
                ApplePayViewControllerRepresentable()
                    .navigationTitle("Payment")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationBarTitle("Apple Pay", displayMode: .inline)
    }
}

struct ApplePayContentView_Previews: PreviewProvider {
    static var previews: some View {
        ApplePayContentView()
    }
}
