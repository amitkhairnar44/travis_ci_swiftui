//
//  LoginView.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentation
    @State var showModal = false
    @State private var message: Message? = nil
    @Binding var accessToken: String
    @Binding var isShowingHomePage: Bool
    
    let server: CIServer
    let buttonID: String
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    VStack(spacing: 8) {
                        server.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 60.0, maxHeight: 60.0)
                            .padding(.vertical, 20.0)
                        Text(server.title)
                            .font(.title3).bold()
                        Text(server.url)
                            .font(.caption).foregroundColor(.blue)
                    }.padding(.all, 10)
                    
                    TextField("Enter access token", text: $accessToken)
                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxHeight: 42.0)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(.all, 24.0)
                    
                    Button {
                        if(accessToken.isEmpty) {
                            self.message = Message(text: "Please enter access token!")
                        } else if(accessToken.count < 22 || accessToken.count > 22){
                            self.message = Message(text: "Please enter correct access token!")
                        } else{
                            // do login process
                            // Use the token and check user exists by calling the api
                            
                            // Dismiss the sheet
                            self.presentation.wrappedValue.dismiss()
                            
                            isShowingHomePage = true
                        }
                    } label:{
                        Text("Login")
                    }.padding()
                    
                    Button{
                        self.showModal.toggle()
                    } label: {
                        Text("How to generate access token?")
                    }
                    if(showModal){
                        VStack(alignment: .leading){
                            Text("To authenticate against the Travis CI API, you need an API access token generated by the Travis CI command line client.")
                                .padding(.vertical, 10)
                            Button("Command Line Client") {}.padding(.vertical, 10)
                            HStack{
                                Text("For more details")
                                Button("click here") {}
                            }
                            Text("Tokens for open source projects, private projects and enterprise installations of Travis CI are not interchangeable.")
                                .foregroundColor(.gray)
                                .padding(.vertical, 10)
                        }.font(.subheadline).padding()
                    }
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Login")
                .navigationBarItems(leading: Button{
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                })
                
            }
        }.alert(item: $message) { message in
            Alert(
                title: Text("Error"),
                message: Text(message.text),
                dismissButton: .cancel()
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var server = CIServer(title: "Org Server", url: "https://travis-ci.org", image: Image(uiImage: #imageLiteral(resourceName: "mascot2")))
    static var previews: some View {
        LoginView(accessToken: .constant(""), isShowingHomePage: .constant(false), server: server, buttonID: "com")
    }
}
