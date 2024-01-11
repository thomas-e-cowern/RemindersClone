//
//  CustomOperators.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding {
        lhs.wrappedValue ?? rhs
    } set: {
        lhs.wrappedValue = $0
    }
}
