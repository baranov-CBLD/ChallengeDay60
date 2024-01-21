//
//  User.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import Foundation
import Observation

struct User: Codable, Identifiable, Hashable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
    
    var registeredFormatted: String {
        if let date = try? Date(registered, strategy: .iso8601) {
            return date.formatted(date: .complete, time: .omitted)
        }
        return "Problems with date"
    }
}

struct Friend: Codable, Hashable, Identifiable {
    let id: String
    let name: String
}

