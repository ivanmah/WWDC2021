//
//  SwiftUIListPullToRefreshView.swift
//  SwiftUIListPullToRefreshView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct SwiftUIListPullToRefreshView: View {
    
    @State private var listItems = ["Red", "Orange", "Green" , "Grey" , "Blue", "Purple","Yellow","Pink"]
    @State var selected : String = ""
    var body: some View {
        List(listItems, id: \.self) { each in
            Text(each)
        }.refreshable {
            //listItems = try await getDataFromAPI()
            listItems.append("New element added")
        }
    }
}

struct SwiftUIListPullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListPullToRefreshView()
    }
}
