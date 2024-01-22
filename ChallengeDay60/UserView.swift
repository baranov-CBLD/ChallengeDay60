//
//  UserView.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import SwiftData
import SwiftUI

struct UserView: View {
    
    @Query var users: [User]
    
    var user: User
    var userVM = UserVM()
    
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
                            path = NavigationPath([users.first(where: { $0.id == friend.id })!])
                    }
                }
            }
        }
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
