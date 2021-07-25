//
//  SwiftUIListSwipeActionView.swift
//  SwiftUIListSwipeActionView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct SwiftUIListSwipeActionView: View {
    
    @State private var list = ["Red", "Orange", "Green", "Blue", "Purple","Yellow","Pink"]
    
    var body: some View {
        List {
            ForEach(list, id: \.self) { each in
                Text(each)
                    .swipeActions {
                        Button(role: .destructive) {
                            list.removeAll(where: { $0 == each })
                        } label: {
                            Label("Delete", systemImage: "xmark.bin")
                        }
                        
                    }
            }
        }
    }
}

struct SwiftUIListSwipeActionView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIListSwipeActionView()
    }
}
