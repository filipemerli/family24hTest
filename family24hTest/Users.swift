//
//  Users.swift
//  family24hTest
//
//  Created by Filipe Merli on 19/03/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

struct Root: Decodable {
    let results: [Users]
}

struct Users: Decodable {
    let id: Int
    let name: Names
    let bio: Mini
}

struct Mini: Decodable {
    let mini: String
}

struct Names: Decodable {
    let first: String
    let last: String
    let title: String
}

extension Root {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Root.self, from: data)
    }
    
}
