//
//  UserTileView.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct UserTileView: View {
    
    @ObservedObject var fetcher : UserDataFetcher
    let id: String
    let accessToken: String
    
    init(id: String, accessToken: String) {
        self.id = id
        self.accessToken = accessToken
        fetcher = UserDataFetcher(id: id, accessToken: accessToken)
    }
    
    var body: some View {
        if self.fetcher.loading {
            ProgressView()
        } else {
            HStack {
                AsyncImage(url: URL(string: fetcher.user.avatarUrl)!,
                           placeholder: {
                            ProgressView()
                           },
                           image: {
                            Image(uiImage: $0).resizable()
                           }
                )
                .frame(width: 24.0, height: 24.0)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0){
                    Text(fetcher.user.name).font(.subheadline).bold()
                    Text(fetcher.user.login).font(.caption)
                }
            }.padding(.vertical, 8)
            
        }
    }
}

struct UserTileView_Previews: PreviewProvider {
    static var previews: some View {
        UserTileView(id: "23", accessToken: "")
    }
}

