//
//  User.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation

struct User: Decodable, Identifiable {
    public var id: Int
    public var name: String
    public var login: String
    public var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}
