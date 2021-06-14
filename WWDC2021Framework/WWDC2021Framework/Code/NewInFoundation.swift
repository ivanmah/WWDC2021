//
//  NewInFoundation.swift
//  WWDC2021
//
//  Created by Ivan Mah on 14/6/21.
//

import Foundation
import SwiftUI
import UIKit

struct NewInFoundation {
    enum RainbowAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
        enum Value: String, Codable {
            case plain
            case fun
            case extreme
        }

        public static var name = "rainbow"
    }

    let important = true

    func createAttributedString() {
        var thanks = AttributedString("Thank you!")
        thanks.font = .body.bold()

        var website = AttributedString("Please visit our website.")
        website.font = .body.italic()
        website.link = URL(string: "https://www.google.com")

        var container = AttributeContainer()

        if important {
            container.foregroundColor = .red
            container.underlineColor = .primary
        } else {
            container.foregroundColor = .primary
        }

        thanks.mergeAttributes(container)
        website.mergeAttributes(container)
    }

    func getMarkdownString() -> String {
        return "This text contains ^[an attribute](rainbow: 'extreme'"
    }

    func oldDateFormatting() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium

        let date = Date.now
        let formattedString = dateFormatter.string(from: date)
    }

    func newDateFormatting() {
        let formattedString = Date.now.formatted(date: .abbreviated, time: .standard)
    }

    func evenMoreNewDateFormatting() {
        let now = Date.now
        let later = now + TimeInterval(5000)

        let formattedString = now.formatted()
        // “28/12/2021, 11:59 AM”

        let formattedStringWithoutTime = now.formatted(date: .numeric, time: .omitted)
        // “28/12/2021”

        let formattedStringWithoutDate = now.formatted(date: .omitted, time: .shortened)
        // “11:59 AM”

        let formattedStringWithFullDate = now.formatted(.dateTime.year().day().month())
        // “Dec 28, 2021”

        let formattedStringWithFullWideDate = now.formatted(.dateTime.year().day().month(.wide))
        // “December 28, 2021”

        let formattedStringWithDay = now.formatted(.dateTime.weekday(.wide))
        // “Tuesday”

        let formattedISO = now.formatted(.iso8601)
        // “20211228T115900Z”

        let formattedStringWithDash = now.formatted(.iso8601.year().month().day().dateSeparator(.dash))
        // “2021-12-28”

        let range = (now ..< later).formatted()
        // “28/12/21, 11:59 AM - 1:22 PM”

        let noDate = (now ..< later).formatted(date: .omitted, time: .complete)
        // “11:59:00 AM GMT+8 - 1:22:20 PM GMT+8”

        let timeDuration = (now ..< later).formatted(.timeDuration)
        // “1:23:20”

        let components = (now ..< later).formatted(.components(style: .wide))
        // “1 hour, 23 minutes, 20 seconds”

        let relative = later.formatted(.relative(presentation: .named, unitsStyle: .wide))
        // “in 1 hour”
    }

    func dateFormattingWithAttributedString() {
        var string = Date.now.formatted(.dateTime
                                            .minute()
                                            .hour()
                                            .weekday()
                                            .locale(Locale.current)
                                            .attributed)

        let weekday = AttributeContainer.dateField(.weekday)
        let color = AttributeContainer.foregroundColor(.orange)

        string.replaceAttributes(weekday, with: color)
    }

    func newStringToDateFormatting() throws {
        let now = Date.now
        let format = Date.FormatStyle().year().month().day()
        let formattedString = now.formatted(format)
        // “Dec 28, 2021”

        if let date = try? Date(formattedString, strategy: format) {
            // “2021-12-28 11:59:00 +0800”
        }

        let strategy = Date.ParseStrategy(format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
                                          timeZone: TimeZone.current)

        let date = try Date("2021-12-28", strategy: strategy)
        // “2021-12-28 00:00:00 +0800”
    }

    func oldStringFormatting() {
        let string = String(format: "%.1f", 0.05)
    }

    func newStringFormatting() {
        let string = 0.05.formatted(.number.precision(.fractionLength(1)))
    }

    func newNumberFormatting() {
        let value = 12345

        let formattedString = value.formatted()
        // “12,345”

        let percent = 25
        let percentFormattedString = percent.formatted(.percent)
        // “25%”

        let scientific = 42e9
        let scientificFormattedString = scientific.formatted(.number.notation(.scientific))
        // “4.2E10”

        let price = 29
        let priceFormattedString = price.formatted(.currency(code: "sgd"))
        // “SGD 29.00”

        let list = [25, 50, 75]
        let listFormattedString = list.formatted(.list(memberStyle: .percent, type: .or))
        // “25%, 50%, or 75%”
    }
}
