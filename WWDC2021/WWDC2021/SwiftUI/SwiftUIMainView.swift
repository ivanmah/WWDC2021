//
//  SwiftUIMainView.swift
//  SwiftUIMainView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct SwiftUIMainView: View {
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            NavigationLink("List with searchable", destination: SwiftUIListview())
            NavigationLink("List with swipe actions", destination: SwiftUIListSwipeActionView())
            NavigationLink("TextField", destination: SwiftUITextfieldView())
        }
        .navigationBarTitle("Swift UI", displayMode: .inline)
    }
}

struct SwiftUIMainView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMainView()
    }
}
