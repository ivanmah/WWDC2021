//
//  SwiftUIListview.swift
//  SwiftUIListview
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

let listItems = ["Red", "Orange", "Green" , "Grey" , "Blue", "Purple","Yellow","Pink"]

struct SwiftUIListSearchableView: View {
    
    @State private var searchQuery = ""
    @State var filteredListView : [String] = listItems
    
    var searchResult : [String] {
        return listItems.filter({ $0.contains(searchQuery)})
    }
    
    var body: some View {
        List(filteredListView, id: \.self) { colour in
            Text(colour)
        }
        .searchable(text: $searchQuery, prompt: "Search Colour", suggestions: {
            ForEach(searchResult, id: \.self) { result in
                Text("Searching for \(result)?").searchCompletion(result)
            }
        }).onChange(of: searchQuery, perform: { newValue in
            if !newValue.isEmpty {
                filteredListView = listItems.filter {$0.contains(newValue) }
            } else {
                filteredListView = listItems
            }
        })
        .navigationBarTitle("List", displayMode: .inline)
    }
}

struct SwiftUIListview_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListSearchableView()
    }
}
