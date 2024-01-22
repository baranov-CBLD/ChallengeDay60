//
//  UserVM.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import Foundation

struct UserVM {
    
    func saveChanges(user: User) async {
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        do {
            let encoded = try JSONEncoder().encode(user)
            let (data, _) = try await URLSession.shared.upload(for: urlRequest, from: encoded)
            let decoded = try JSONDecoder().decode(User.self, from: data)
            print(String(decoding: data, as: UTF8.self))
            print("data sended:", decoded.name)
        } catch let errorMessage {
            print("Checkout failed: \(errorMessage)")
        }
        
    }
}
