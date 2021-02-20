//
//  BuildLogDataSource.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation

public class BuildLogDataSource: ObservableObject {
    @Published var log = BuildLog(id: 0, content: "")
    @Published var loading = false
    @Published var errored = false
    
    let id: String
    let accessToken: String
    
    init(id: String, accessToken: String){
        self.id = id
        self.accessToken = accessToken
        load()
    }
    
    func load() {
        print("Fetching logs...")
        self.loading = true
        let url = URL(string: "https://api.travis-ci.org/job/\(id)/log")!
        
        var request = URLRequest(url: url)
        request.setValue("3", forHTTPHeaderField: "Travis-API-Version")
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {(data,response,error) in
            //print(response as Any)
            do {
                if let d = data {
                    let decodedLog = try JSONDecoder().decode(BuildLog.self, from: d)
                    DispatchQueue.main.async {
                        self.log = decodedLog
                        self.loading = false
                    }
                } else {
                    print("No Data")
                    self.loading = false
                    self.errored = false
                }
            } catch {
                print (error)
                self.loading = false
                self.errored = true
            }
        }.resume()
        
    }
}
