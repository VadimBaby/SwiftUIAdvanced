//
//  PreferenceKeys.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 08.12.2023.
//

import Foundation
import SwiftUI

struct SuccessPreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct ErrorPreferenceKey: PreferenceKey {
    static var defaultValue: () -> Void = {}
    
    static func reduce(value: inout () -> Void, nextValue: () -> () -> Void) {
        value = nextValue()
    }
}
