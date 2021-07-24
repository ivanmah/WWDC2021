//
//  SwiftUIAsyncImage.swift
//  SwiftUIAsyncImage
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

struct SwiftUIAsyncImage: View {
    let url = URL(string: "https://www.littledayout.com/wp-content/uploads/e-NationalDay2017-1.png")
    
    var body: some View {
        AsyncImage(url: url) { img in
            img.resizable().scaledToFit()
        } placeholder: {
            Image(systemName: "heart")
                .foregroundColor(.red)
                .font(.system(size: 100))
        }
    }
}

struct SwiftUIAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAsyncImage()
    }
}
