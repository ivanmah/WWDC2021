//
//  FoundationWithDateFormattingMoreViewContent.swift
//  WWDC2021
//
//  Created by Ivan Mah on 23/7/21.
//

import SwiftUI

struct FoundationWithDateFormattingMoreViewContent: View {
    private let now = Date.now

    var body: some View {
        VStack(spacing: 20.0) {
            Group {
                Text("Date and Time: **\(now.formatted())**")
                Text("Date only: **\(now.formatted(date: .numeric, time: .omitted))**")
                Text("Time only: **\(now.formatted(date: .omitted, time: .shortened))**")
                Text("Abbreviated Date: **\(now.formatted(.dateTime.year().day().month()))**")
                Text("Full Date: **\(now.formatted(.dateTime.year().day().month(.wide)))**")
                Text("Day only: **\(now.formatted(.dateTime.weekday(.wide)))**")
                Text("ISO8601 Date and Time: **\(now.formatted(.iso8601))**")
                Text("ISO8601 Date: **\(now.formatted(.iso8601.year().month().day().dateSeparator(.dash)))**")
                Text("Abbreviated Date Range: **\((now ..< getLater()).formatted())**")
                Text("Full Date Range: **\((now ..< getLater()).formatted(date: .omitted, time: .complete))**")
                    .multilineTextAlignment(.center)
            }

            Group {
                Text("Time duration: **\((now ..< getLater()).formatted(.timeDuration))**")
                Text("Time components: **\((now ..< getLater()).formatted(.components(style: .wide)))**")
                Text("Relative Time: **\(getLater().formatted(.relative(presentation: .named, unitsStyle: .wide)))**")
                Text("Date AttributedString: **\(getDateAttributedString())**")
                Text("First String To Date: **\(getFirstStringToDateFormatting().formatted())**")
                Text("Second String To Date: **\(getSecondStringToDateFormatting().formatted())**")
            }
        }
        .navigationTitle("More DateFormatting")
    }
}

extension FoundationWithDateFormattingMoreViewContent {
    private func getLater() -> Date {
        return now + TimeInterval(5000)
    }

    private func getDateAttributedString() -> AttributedString {
        var string = Date.now.formatted(.dateTime
                                            .minute()
                                            .hour()
                                            .weekday()
                                            .locale(Locale.current)
                                            .attributed)

        let weekday = AttributeContainer.dateField(.weekday)
        let color = AttributeContainer.foregroundColor(.orange)

        string.replaceAttributes(weekday, with: color)

        return string
    }

    private func getFirstStringToDateFormatting() -> Date {
        let format = Date.FormatStyle().year().month().day()

        do {
            return try Date("Jul 29 2021", strategy: format)
        } catch {
            return now
        }
    }

    private func getSecondStringToDateFormatting() -> Date {
        let strategy = Date.ParseStrategy(format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
                                          timeZone: TimeZone.current)

        do {
            return try Date("2021-07-29", strategy: strategy)
        } catch {
            return now
        }
    }
}

struct FoundationWithDateFormattingMoreViewContent_Previews: PreviewProvider {
    static var previews: some View {
        FoundationWithDateFormattingMoreViewContent()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
