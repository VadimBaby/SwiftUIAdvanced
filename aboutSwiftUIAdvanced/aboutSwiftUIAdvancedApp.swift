//
//  aboutSwiftUIAdvancedApp.swift
//  aboutSwiftUIAdvanced
//
//  Created by Вадим Мартыненко on 15.10.2023.
//

import SwiftUI

@main
struct aboutSwiftUIAdvancedApp: App {
    
    let currentUserSignIn: Bool
    
    init() {
//        let value = ProcessInfo.processInfo.environment["-UITests_startSignedIn2"]
//        let userIsSignIn: Bool = value == "true" ? true : false
        
      //  let userIsSignIn: Bool = CommandLine.arguments.contains("-UITests_startSignedIn") ? true : false
        
        let userIsSignIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITests_startSignedIn") ? true : false
        
        self.currentUserSignIn = userIsSignIn
    }
    
    var body: some Scene {
        WindowGroup {
            AdvancedCombineBootcamp()
        }
    }
}
