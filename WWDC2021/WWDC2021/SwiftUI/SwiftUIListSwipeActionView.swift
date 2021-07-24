//
//  SwiftUIListSwipeActionView.swift
//  SwiftUIListSwipeActionView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct SwiftUIListSwipeActionView: View {
    //var list = listItems.map { $0.copy() as! String }
    var list : NSMutableArray = NSMutableArray.init(array: listItems)
    var body: some View {
        List {
            ForEach(listItems, id: \.self) { each in
                Text(each)
                    .swipeActions {
                        Button(role: .destructive) {
                            list.remove(each)
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
