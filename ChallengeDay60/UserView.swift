//
//  UserView.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import SwiftUI

struct UserView: View {
    
    @Environment(UserVM.self) var userVM
    
    var user: User
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        List {
            Section("Status") {
                Text(user.isActive ? "Online" : "Offline")
            }
            Section(header: Text("About me")) {
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("\(user.about)")
                Text("Registered: \(user.registeredFormatted)")
                Text("Tags: \(user.tags.joined(separator: ", "))")
            }
            Section("Friends") {
                ForEach (user.friends) { friend in
                    Button(friend.name) {
                            path = NavigationPath([userVM.users.first(where: { $0.id == friend.id })!])
                    }
//                    NavigationLink(friend.name, value: friend)
                }
            }
        }
//        .navigationDestination(for: Friend.self) { friend in
//            UserView(user: userVM.users.first(where: { $0.id == friend.id })!, path: $path)
//        }
        .navigationTitle(user.name)
        .toolbar {
            Button("Save") {
                Task {
                   await userVM.saveChanges(user: user)
                }
            }
        }
    }
}

#Preview {
    UserView(user: UserVM.usersExample.users[0], path: .constant(NavigationPath()))
        .environment(UserVM.usersExample)
}
