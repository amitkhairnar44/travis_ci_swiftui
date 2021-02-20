//
//  ServerButton.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct ServerButton: View {
    @State var showModal = false
    let server: CIServer
    let buttonID: String
    let buttonTitle: String
    @Binding var isShowingHomePage: Bool
    @Binding var accessToken: String
    
    var body: some View {
        Button {
            showModal.toggle()
        } label:{
            VStack(spacing: 8) {
                server.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 60.0, maxHeight: 60.0)
                
                Text(buttonTitle)
                    .font(.title3)
            }
            .padding()
            .frame(maxWidth: 200.0)
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color(UIColor.systemGray), lineWidth: 0.2)
            )
        }.sheet(isPresented: $showModal, onDismiss: {
            //print(self.showModal)
        }) {
            LoginView(accessToken: $accessToken, isShowingHomePage: $isShowingHomePage, server: server, buttonID: buttonID)
        }
    }
}

struct ServerButton_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ServerButton(showModal: true, server: CIServer(title: "Com Server", url: "https://travis-ci.com", image: Image(uiImage: #imageLiteral(resourceName: "mascot2"))), buttonID: "com", buttonTitle: "Travis CI (.com)", isShowingHomePage: .constant(false), accessToken: .constant(""))
    }
}
