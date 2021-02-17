//
//  CIServer.swift
//  Travis CI
//
//  Created by Amit Khairnar on 17/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct CIServer: Identifiable {
    let id = UUID()
    let title: String
    let url: String
    let image: Image
}
