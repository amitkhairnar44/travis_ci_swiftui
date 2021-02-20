//
//  Branch.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation

struct Branch: Decodable {
    public var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
