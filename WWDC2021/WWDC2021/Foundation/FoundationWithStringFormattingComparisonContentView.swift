//
//  FoundationWithStringFormattingComparisonContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 23/7/21.
//

import SwiftUI

struct FoundationWithStringFormattingComparisonContentView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            Text("Old String Formatting: **\(String(format: "%.2f", Double.pi))**")
            Text("New String Formatting: **\(Double.pi.formatted(.number.precision(.fractionLength(2))))**")
        }
        .navigationTitle("StringFormatting Comparison")
    }
}

struct FoundationWithStringFormattingComparisonContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoundationWithStringFormattingComparisonContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
