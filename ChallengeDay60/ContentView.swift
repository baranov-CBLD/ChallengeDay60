//
//  ContentView.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
        
    @State private var path = NavigationPath()
    
    @State private var dataLoaded = false
    
    var body: some View {
        NavigationStack(path: $path) {
            
            if dataLoaded {
                UsersView(path: $path)
            } else {
                Text("Data is loading")
            }
        }
        .task {
            dataLoaded = await loadUsers(modelContext: modelContext)
        }
    }
    
}

#Preview {
    ContentView()
}
