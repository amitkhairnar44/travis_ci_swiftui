//
//  Repo.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation


struct Repositories: Decodable {
    public var repositories: [Repo]
    public var pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case repositories = "repositories"
        case pagination = "@pagination"
    }
}

struct Owner: Decodable {
    public var login: String
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
    }
}

struct Repo: Decodable, Identifiable {
    public var id: Int
    public var active: Bool
    public var starred: Bool
    public var name: String
    public var slug: String
    public var owner: Owner
    public var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case owner = "owner"
        case active = "active"
        case starred = "starred"
        case description = "description"
    }
}
