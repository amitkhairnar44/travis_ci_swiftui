//
//  Message.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
}
