//
//  APIClient.swift
//  family24hTest
//
//  Created by Filipe Merli on 19/03/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

class ParseAPIClient: NSObject {
    
    // MARK: Properties
    
    var session = URLSession.shared
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    //func taskForGetUsers(handlerGetUsers)
    
   
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseAPIClient{
        struct Singleton{
            static var sharedInstance = ParseAPIClient()
        }
        return Singleton.sharedInstance
    }
    
    // PASSAR PARA CONVINIENCE
    
    
    
}
