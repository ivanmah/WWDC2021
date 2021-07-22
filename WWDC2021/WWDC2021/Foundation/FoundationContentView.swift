//
//  FoundationContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import SwiftUI

struct FoundationContentView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            NavigationLink("AttributedString") {
                FoundationWithAttributedStringContentView()
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("DateFormatting Comparison") {
                FoundationWithDateFormattingComparisonViewContent()
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("More DateFormatting") {
                FoundationWithDateFormattingMoreViewContent()
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("StringFormatting Comparison") {
                FoundationWithStringFormattingComparisonContentView()
                    .navigationBarTitleDisplayMode(.inline)
            }

            NavigationLink("NumberFormatting") {
                FoundationWithNumberFormattingContentView()
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationTitle("Foundation")
    }
}

struct FoundationContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoundationContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
