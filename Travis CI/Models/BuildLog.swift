//
//  BuildLog.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation

struct BuildLog: Decodable {
    public var id: Int
    public var content: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case content = "content"
    }
}
