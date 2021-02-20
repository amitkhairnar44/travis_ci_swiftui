//
//  HomePage.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    @State private var selection = 0
    let accessToken: String
    
    var body: some View {
        TabView(selection: $selection) {
            ActiveReposView(accessToken: accessToken)
            .tabItem {
                Image(systemName: "folder.badge.gear")
                Text("Active Repos")
            }
            .tag(0)
            
            Text("All Repos \(accessToken)")
                .tabItem {
                    Image(systemName: "folder")
                    Text("All Repos")
                }
                .tag(1)
            
            Text("Builds")
                .tabItem {
                    Image(systemName: "gearshape.2")
                    Text("Builds")
                }
                .tag(2)
            
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(3)
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(accessToken: "")
    }
}
