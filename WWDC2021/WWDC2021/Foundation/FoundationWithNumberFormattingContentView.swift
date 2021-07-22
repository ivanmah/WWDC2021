//
//  FoundationWithNumberFormattingContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 23/7/21.
//

import SwiftUI

struct FoundationWithNumberFormattingContentView: View {
    let value = 12345
    let percentage = 25
    let scientificValue = 4e25
    let price = 29
    let list = [25, 50, 75]

    var body: some View {
        VStack(spacing: 20.0) {
            Text("String Formatting: **\(value.formatted())**")
            Text("Percentage Formatting: **\(percentage.formatted(.percent))**")
            Text("Scientific Formatting: **\(scientificValue.formatted(.number.notation(.scientific)))**")
            Text("Full Scientific Formatting: **\(scientificValue.formatted(.number.notation(.automatic)))**")
                .multilineTextAlignment(.center)
            Text("SGD Price Formatting: **\(price.formatted(.currency(code: "sgd")))**")
            Text("JPY Price Formatting: **\(price.formatted(.currency(code: "jpy")))**")
            Text("List Formatting: **\(list.formatted(.list(memberStyle: .percent, type: .or)))**")
        }
        .navigationTitle("NumberFormatting")
    }
}

struct FoundationWithNumberFormattingContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoundationWithNumberFormattingContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
