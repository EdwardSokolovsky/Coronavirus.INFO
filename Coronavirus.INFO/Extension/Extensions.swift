//
//  Extensions.swift
//  Coronavirus.INFO
//
//  Created by Edward on 21.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation
import SwiftUI

extension String {
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func slices(from: String, to: String) -> [Substring] {
        let pattern = "(?<=" + from + ").*?(?=" + to + ")"
        return ranges(of: pattern, options: .regularExpression)
            .map{ self[$0] }
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
