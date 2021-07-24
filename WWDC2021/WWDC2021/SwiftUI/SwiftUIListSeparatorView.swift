//
//  SwiftUIListSeparatorView.swift
//  SwiftUIListSeparatorView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct SwiftUIListSeparatorView: View {
    var body: some View {
        List {
            ForEach(listItems, id: \.self) { each in
                Text(each)
                    .listRowSeparatorTint(.red, edges: .all)
            }
        }
    }
}

struct SwiftUIListSeparatorView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListSeparatorView()
    }
}
