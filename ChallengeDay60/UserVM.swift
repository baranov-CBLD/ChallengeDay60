//
//  UserVM.swift
//  ChallengeDay60
//
//  Created by Kirill Baranov on 21/01/24.
//

import Foundation
import Observation

@Observable
class UserVM {
    
    var users: [User]
    
    init() {
        self.users = []
    }
    
    func loadUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
//            print(String(decoding: data, as: UTF8.self))
            do {
                let decoded = try JSONDecoder().decode([User].self, from: data)
                self.users = decoded
                
            } catch let decodingError {
                print("Error decoding JSON: \(decodingError)")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
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
            print("data sended")
        } catch let errorMessage {
            print("Checkout failed: \(errorMessage)")
        }
        
    }
    
    
    static private let jsonExample = """
[
    {
        "id": "50a48fa3-2c0f-4397-ac50-64da464f9954",
        "isActive": false,
        "name": "Alford Rodriguez",
        "age": 21,
        "company": "Imkan",
        "email": "alfordrodriguez@imkan.com",
        "address": "907 Nelson Street, Cotopaxi, South Dakota, 5913",
        "about": "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
        "registered": "2015-11-10T01:47:18-00:00",
        "tags": [
            "cillum",
            "consequat",
            "deserunt",
            "nostrud",
            "eiusmod",
            "minim",
            "tempor"
        ],
        "friends": [
            {
                "id": "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0",
                "name": "Hawkins Patel"
            },
            {
                "id": "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6",
                "name": "Jewel Sexton"
            },
            {
                "id": "be5918a3-8dc2-4f77-947c-7d02f69a58fe",
                "name": "Berger Robertson"
            },
            {
                "id": "f2f86852-8f2d-46d3-9de5-5bed1af9e4d6",
                "name": "Hess Ford"
            },
            {
                "id": "6ba32d1b-38d7-4b0f-ba33-1275345eacc0",
                "name": "Bonita White"
            },
            {
                "id": "4b9bf1e5-abec-4ee3-8135-3a838df90cef",
                "name": "Sheryl Robinson"
            },
            {
                "id": "5890bacd-f49c-4ea2-b8fa-02db0e083238",
                "name": "Karin Collins"
            },
            {
                "id": "29e0f9ee-71f2-4043-ad36-9d2d6789b2c8",
                "name": "Pace English"
            },
            {
                "id": "aa1f8001-59a3-4b3c-bf5e-4a7e1d8563f2",
                "name": "Pauline Dawson"
            },
            {
                "id": "d09ffb09-8adc-48e1-a532-b99ae72473d4",
                "name": "Russo Carlson"
            },
            {
                "id": "7ef1899e-96e4-4a76-8047-0e49f35d2b2c",
                "name": "Josefina Rivas"
            }
        ]
    },
    {
        "id": "eccdf4b8-c9f6-4eeb-8832-28027eb70155",
        "isActive": true,
        "name": "Gale Dyer",
        "age": 28,
        "company": "Cemention",
        "email": "galedyer@cemention.com",
        "address": "652 Gatling Place, Kieler, Arizona, 1705",
        "about": "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.",
        "registered": "2014-07-05T04:25:04-01:00",
        "tags": [
            "irure",
            "labore",
            "et",
            "sint",
            "velit",
            "mollit",
            "et"
        ],
        "friends": [
            {
                "id": "1c18ccf0-2647-497b-b7b4-119f982e6292",
                "name": "Daisy Bond"
            },
            {
                "id": "a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9",
                "name": "Tanya Roberson"
            }
        ]
    }
]
"""
    static var usersExample: UserVM {
        let userVM = UserVM()
        userVM.users = try! JSONDecoder().decode([User].self, from: jsonExample.data(using: .utf8)!)
        return userVM
    }
    
}
