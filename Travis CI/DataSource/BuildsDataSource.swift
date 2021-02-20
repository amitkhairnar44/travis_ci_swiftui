//
//  BuildsDataSource.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BuildsDataSource: ObservableObject {
    @Published var builds = [Build]()
    @Published var isLoadingPage = false
    @Published var id: String
    @Published var accessToken: String
    
    private var currentPage = 1
    private var canLoadMorePages = true
    private var offset: Int = 0
    
    init(id: String, accessToken: String) {
        self.id = id
        self.accessToken = accessToken
        loadMoreContent()
    }
    
    func loadMoreContentIfNeeded(currentItem item: Build?) {
        guard let item = item else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = builds.index(builds.endIndex, offsetBy: -5)
        if builds.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    enum HTTPError: LocalizedError {
        case statusCode
    }
    
    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        
        isLoadingPage = true
        
        let url = URL(string: "https://api.travis-ci.org/repo/\(id)/builds?limit=25&offset=\(offset)")!
        
        //TODO: Do error handling
        
        var request = URLRequest(url: url)
        request.setValue("3", forHTTPHeaderField: "Travis-API-Version")
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskPublisher(for: request)
            //.map(\.data)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("error")
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: Builds.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { response in
                self.canLoadMorePages = !response.pagination.isLast
                self.offset = response.pagination.next?.offset ?? 0
                self.isLoadingPage = false
                self.currentPage += 1
            })
            .map({ response in
                return self.builds + response.builds
            })
            .catch({ _ in Just(self.builds)})
            .assign(to: &$builds)
    }
}
