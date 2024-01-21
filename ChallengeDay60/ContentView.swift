//
//  ContentView.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(UserVM.self) var userVM
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach (userVM.users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.name)
                            Spacer()
                            if user.isActive {
                                Text("Online")
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserView(user: user, path: $path)
            }
        }
    }
}

#Preview {
    return ContentView()
        .environment(UserVM.usersExample)
}
