//
//  BuildLogView.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct BuildLogView: View {
    
    let accessToken: String
    let id: String
    
    @StateObject private var buildLogDataSource: BuildLogDataSource
    
    init(id: String, accessToken: String) {
        self.id = id
        self.accessToken = accessToken
        // This is a workaround as shown here: https://stackoverflow.com/questions/62635914/initialize-stateobject-with-a-parameter-in-swiftui
        _buildLogDataSource = StateObject(wrappedValue: BuildLogDataSource(id: id, accessToken: accessToken))
    }
    
    func logString() -> [String] {
        return buildLogDataSource.log.content!.split(separator: "\n").map(String.init)
    }
    
    var body: some View {
        
        if self.buildLogDataSource.loading {
            ProgressView()
        }
        else{
            ScrollView{
                LazyVStack(alignment: .leading){
                    
                    ForEach(logString(), id: \.self) { someString in
                        
                        Text(someString).font(.caption2).padding(.vertical, 2)
                            //.fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .navigationBarTitle("Logs", displayMode: .inline)
        }
        
    }
}

struct BuildLogView_Previews: PreviewProvider {
    static var previews: some View {
        BuildLogView(id: "", accessToken: "")
    }
}
