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
    let id: Int?
    let picture: Sizes?
    let name: Names?
    let bio: Text?
    let email: String?
    let location: Loc?
}

struct Sizes: Decodable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}

struct Text: Decodable {
    let mini: String?
    let full: String?
}

struct Names: Decodable {
    let first: String?
    let last: String?
    let title: String?
}

struct Loc: Decodable {
    let city: String?

}

extension Root {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Root.self, from: data)
    }
    
}
