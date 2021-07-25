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
            ForEach((1...3), id: \.self) {
                Section(header: Text("This is section \($0)")) {
                    ForEach(listItems, id: \.self) { each in
                        Text(each)
                            .listRowSeparatorTint(.red, edges: .all)
                            //.listRowSeparator(.hidden, edges: .all)
                    }
                }
                //.listSectionSeparator(.visible)
                .listSectionSeparatorTint(.blue, edges: .all)
            }
        }.listStyle(GroupedListStyle())
    }
}

struct SwiftUIListSeparatorView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListSeparatorView()
    }
}
