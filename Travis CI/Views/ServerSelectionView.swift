//
//  ServerSelectionView.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct ServerSelectionView: View {
    
    @Namespace var namespace
    
    var body: some View {
        VStack(alignment: .center){
            Text("Select CI Server").font(.title2).padding()
            
            ServerButton(
                server: CIServer(
                    title: "Org Server",
                    url: "https://travis-ci.org",
                    image: Image(uiImage: #imageLiteral(resourceName: "mascot1"))
                ),
                buttonID: "org",
                buttonTitle: "Travis CI (.org)",
                namespace: namespace
            )
            
            ServerButton(
                server: CIServer(
                    title: "Com Server",
                    url: "https://travis-ci.com",
                    image: Image(uiImage: #imageLiteral(resourceName: "mascot2"))
                ),
                buttonID: "com",
                buttonTitle: "Travis CI (.com)",
                namespace: namespace
            )
        }
    }
}

struct ServerSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ServerSelectionView()
    }
}
