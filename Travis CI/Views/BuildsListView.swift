//
//  BuildsListView.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct BuildsListView: View {
    let id: String
    let accessToken: String
    
    @StateObject private var buildsDataSource: BuildsDataSource
    
    init(id: String, accessToken: String) {
        self.id = id
        self.accessToken = accessToken
        // This is a workaround as shown here: https://stackoverflow.com/questions/62635914/initialize-stateobject-with-a-parameter-in-swiftui
        _buildsDataSource = StateObject(wrappedValue: BuildsDataSource(id: id, accessToken: accessToken))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading){
                ForEach(buildsDataSource.builds){ build in
                    NavigationLink(destination: BuildDetails(build: build, accessToken: accessToken)){
                        HStack(alignment: .top){
                            Text("#\(build.number)")
                                .onAppear {
                                    buildsDataSource.loadMoreContentIfNeeded(currentItem: build)
                                }
                            VStack(alignment: .leading){
                                Text(build.commit!.message)
                                HStack{
                                    Image(systemName: stateIcon(for: build.state)).font(.system(size: 16, weight: .bold))
                                    Text(build.state).bold()
                                }.foregroundColor(stateColor(for: build.state))
                            }
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }.foregroundColor(Color(UIColor.label))
                    
                }
            }
            .navigationTitle("Builds")
            
            if buildsDataSource.isLoadingPage {
                ProgressView()
            }
        }
    }
}

struct BuildsListView_Previews: PreviewProvider {
    static var previews: some View {
        BuildsListView(id: "", accessToken: "")
    }
}
