//
//  SwiftUIListview.swift
//  SwiftUIListview
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

let listItems = ["Red", "Orange", "Green", "Blue", "Purple","Yellow","Pink"]

struct SwiftUIListSearchableView: View {
    
    @State private var searchQuery = ""
    
    var searchResult : [String] {
        if searchQuery.isEmpty {
            return listItems
        } else {
            return listItems.filter({ $0.contains(searchQuery)})
        }
    }
    
    var body: some View {
        List(searchResult, id: \.self) { colour in
            Text(colour)
        }
        .searchable(text: $searchQuery, prompt: "Search Colour", suggestions: {
//            ForEach(searchResult, id: \.self) { result in
//                Text(result).searchCompletion(result)
//            }
        })
        .navigationBarTitle("List", displayMode: .inline)
    }
}

struct SwiftUIListview_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListSearchableView()
    }
}
