//
//  APIConstants.swift
//  family24hTest
//
//  Created by Filipe Merli on 19/03/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

extension ParseAPIClient {
    struct ParseConstants {
        static let startNumber: Int = 1
        static let limitNumber: Int = 20
        static let parseUrl = "http://testmobiledev.eokoe.com/users"
        static let apiKey = "d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35"
        static let getStart = "?start=\(startNumber)"
        static let getLimit = "?limit=\(limitNumber)"
        static let headerAPIKey = "X-API-Key"
        
    }
}
