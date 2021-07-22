//
//  FoundationWithAttributedStringContentView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import SwiftUI

struct FoundationWithAttributedStringContentView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            Text("This is regular text")
            Text(getFirstAttributedString())
            Text(getSecondAttributedString())
            Text("**This is bold Markdown text**")
            Text("*This is italic Markdown text*")
            Text("This is **bold** text, this is *italic* text, and this is ***bold, italic*** text")
                .multilineTextAlignment(.center)
            Text("~~This is strikethrough text~~")
            Text("`This is monospaced text`")
            Text("This is a Markdown link: [Click Me](https://www.apple.com)")
        }
        .navigationTitle("AttributedString")
    }
}

extension FoundationWithAttributedStringContentView {
    private func getFirstAttributedString() -> AttributedString {
        var container = AttributeContainer()
        container.foregroundColor = .red
        container.underlineColor = .primary

        var thanks = AttributedString("This is an AttributedString")
        thanks.font = .body.bold()
        thanks.mergeAttributes(container)

        return thanks
    }

    private func getSecondAttributedString() -> AttributedString {
        var container = AttributeContainer()
        container.foregroundColor = .primary

        var website = AttributedString("This is an AttributedString link")
        website.font = .body.italic()
        website.link = URL(string: "https://www.google.com")
        website.mergeAttributes(container)

        return website
    }
}

struct FoundationWithAttributedStringContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoundationWithAttributedStringContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
