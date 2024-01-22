//
//  ChallengeDay60App.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import SwiftData
import SwiftUI

@main
struct ChallengeDay60App: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)

        }
        
    }
}
