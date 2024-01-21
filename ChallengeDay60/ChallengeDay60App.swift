//
//  ChallengeDay60App.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import SwiftUI

@main
struct ChallengeDay60App: App {
    
    var userVM = UserVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await userVM.loadUsers()
                }
                .environment(userVM)
        }
        
    }
}
