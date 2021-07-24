//
//  SwiftUITextfieldView.swift
//  SwiftUITextfieldView
//
//  Created by Chia Wei Zheng Terry on 24/7/21.
//

import SwiftUI

enum Field {
    case user
    case emailAddress
    case password
}

struct SwiftUITextfieldView: View {
    
    @State var username = ""
    @State var emailAddress = ""
    @State var password = ""
    
    @FocusState var activeState : Field?
    
    var body: some View {
        
        VStack (alignment: .center, spacing: 20) {
            
            VStack(spacing: 20) {
                
                TextField("UserName", text: $username)
                    .focused($activeState, equals: .user)
                .submitLabel(.done)
                
                TextField("Email Address", text: $emailAddress)
                    .focused($activeState, equals: .emailAddress)
                    .submitLabel(.send)
                
                SecureField("Password", text: $password)
                    .focused($activeState, equals: .password)
                    .submitLabel(.go)
                
            }.padding(50)
            .textFieldStyle(.roundedBorder)
            
            Button("Enter Username") {
                activeState = .user
            }
            
            Button("Enter Email") {
                activeState = .emailAddress
            }
            
            Button("Enter Password") {
                activeState = .password
            }
        }
        
        .navigationBarTitle("TextView", displayMode: .inline)
    }
}

struct SwiftUITextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITextfieldView()
    }
}
