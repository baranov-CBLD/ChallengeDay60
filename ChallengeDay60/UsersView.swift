//
//  UsersView.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 22/01/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    @Query var users: [User]
    @Binding var path: NavigationPath
    
    var body: some View {
        
        List {
            ForEach (users) { user in
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

//#Preview {
//    UsersView()
//}
