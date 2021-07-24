//
//  FoundationWithDateFormattingComparisonViewContent.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import SwiftUI

struct FoundationWithDateFormattingComparisonViewContent: View {
    private let now = Date.now

    var body: some View {
        VStack(spacing: 20.0) {
            Text("Old Formatting: **\(getDateFromOldFormatting())**")
            Text("New Formatting: **\(getDateFromNewFormatting())**")
        }
        .navigationTitle("DateFormatting Comparison")
    }
}

extension FoundationWithDateFormattingComparisonViewContent {
    private func getDateFromOldFormatting() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"

        return dateFormatter.string(from: now)
    }

    private func getDateFromNewFormatting() -> String {
        return now.formatted(.dateTime.day().month(.abbreviated).year())
    }
}

struct FoundationWithDateFormattingComparisonViewContent_Previews: PreviewProvider {
    static var previews: some View {
        FoundationWithDateFormattingComparisonViewContent()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
