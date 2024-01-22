//
//  dataExstension.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 22/01/24.
//

import Foundation
import SwiftUI
import SwiftData

extension View {
    
    func loadUsers(modelContext: ModelContext) async -> Bool {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return false
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
//            print(String(decoding: data, as: UTF8.self))

            do {
                
                let decoded = try JSONDecoder().decode([User].self, from: data)
                
                try modelContext.delete(model: User.self)
                
                for user in decoded {
                    modelContext.insert(user)
                }
                
                return true
                
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
                return false
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
    
}
