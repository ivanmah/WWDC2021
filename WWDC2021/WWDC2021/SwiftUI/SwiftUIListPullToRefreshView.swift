//
//  SwiftUIListPullToRefreshView.swift
//  SwiftUIListPullToRefreshView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct SwiftUIListPullToRefreshView: View {
    @State var selected : String = ""
    var body: some View {
        List(listItems, id: \.self) { each in
            Text(each)
        }.refreshable {
            //await getDataFromAPI()
        }
    }
}

struct SwiftUIListPullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListPullToRefreshView()
    }
}
