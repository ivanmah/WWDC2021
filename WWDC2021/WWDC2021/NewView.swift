//
//  NewView.swift
//  WWDC2021
//
//  Created by Ivan Mah on 22/7/21.
//

import SwiftUI

struct NewView: View {
    var body: some View {
        Text("Second View")
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
