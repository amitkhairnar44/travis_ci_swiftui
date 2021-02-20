//
//  BuildStateHelper.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

public func stateColor(for state: String) -> Color {
    switch (state) {
    case "passed": return .green
    case "canceled": return .gray
    case "started": return .gray
    case "errored": return .red
    case "failed": return .red
    default:
        return .gray
    }
}

public func stateIcon(for state: String) -> String {
    switch (state) {
    case "passed": return "checkmark"
    case "canceled": return "slash.circle"
    case "started": return "ellipsis"
    case "errored": return "exclamationmark"
    case "failed": return "xmark"
    default:
        return "ellipsis"
    }
}
