//
//  ActiveReposDataSource.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ActiveReposDataSource: ObservableObject {
    @Published var activeRepos = [Repo]()
    @Published var isLoadingPage = false
    @Published var accessToken: String
    
    private var currentPage = 1
    private var canLoadMorePages = true
    private var offset: Int = 0
    
    init(accessToken: String) {
        self.accessToken = accessToken
        loadMoreContent()
    }
    
    func loadMoreContentIfNeeded(currentItem item: Repo?) {
        guard let item = item else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = activeRepos.index(activeRepos.endIndex, offsetBy: -5)
        if activeRepos.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
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
        let url = URL(string: "https://api.travis-ci.org/repos?limit=10&repository.active=true&offset=\(offset)&sort_by=default_branch.last_build:desc")!
        
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
            .decode(type: Repositories.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { response in
                self.canLoadMorePages = !response.pagination.isLast
                self.offset = response.pagination.next?.offset ?? 0
                self.isLoadingPage = false
                self.currentPage += 1
            })
            .map({ response in
                //print(response as Any)
                return self.activeRepos + response.repositories
            })
            .catch({ _ in Just(self.activeRepos)})
            .assign(to: &$activeRepos)
    }
}
