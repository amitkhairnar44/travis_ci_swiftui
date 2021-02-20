//
//  ActiveReposView.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct ActiveReposView: View {
    
    let accessToken: String
    
    @StateObject private var activeReposDataSource: ActiveReposDataSource
    
    init(accessToken: String) {
        self.accessToken = accessToken
        // This is a workaround as shown here: https://stackoverflow.com/questions/62635914/initialize-stateobject-with-a-parameter-in-swiftui
        _activeReposDataSource = StateObject(wrappedValue: ActiveReposDataSource(accessToken: accessToken))
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    ForEach(activeReposDataSource.activeRepos, id: \.id){ repo in
                        NavigationLink(destination: BuildsListView(id: "\(repo.id)", accessToken: accessToken)) {
                            HStack {
                                Image(systemName:"folder")
                                    .foregroundColor(Color(UIColor.label))
                                VStack(alignment: .leading, spacing: 4){
                                    Text(repo.name).font(.title3)
                                    Text(repo.owner.login).font(.caption)
                                }.foregroundColor(Color(UIColor.label))
                                Spacer()
                                Image(systemName: repo.starred ? "star.fill" : "star")
                                    .foregroundColor(repo.starred ? .orange : .gray)
                            }.padding(.vertical, 8)
                            .onAppear {
                                activeReposDataSource.loadMoreContentIfNeeded(currentItem: repo)
                            }
                        }
                    }
                    
                }.padding()
                
                if activeReposDataSource.isLoadingPage {
                    ProgressView()
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Active Repositories")
        }
    }
}


struct ActiveReposView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveReposView(accessToken: "")
    }
}
