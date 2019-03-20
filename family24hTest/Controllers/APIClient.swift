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
    
    func taskForGetUser(handlerGetUser: @escaping(_ results: AnyObject?, _ error: Error?) -> Void) {
        var request = URLRequest(url: URL(string: "\(ParseConstants.parseUrl)")!)
        request.addValue("\(ParseConstants.apiKey)", forHTTPHeaderField: "\(ParseConstants.headerAPIKey)")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                handlerGetUser(nil, error)
                return
            }
            self.convertData(data!) { results, error in
                if let error = error {
                    handlerGetUser(nil, error)
                } else {
                    if let results = results?["results"] as? [[String:AnyObject]] {
                        
                        //let locations = StudentLoc.locationsFromResults(results)
                        print("\(results)")
                        handlerGetUser(results as AnyObject, nil)
                    } else {
                        handlerGetUser(nil, NSError(domain: "getParseAPI parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse locations"]))
                    }
                }
            }
        }
        task.resume()
    }
    
    private func convertData(_ data: Data, handlerConvertData: (_ result: AnyObject?,_ error: NSError?) -> Void) {
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Nao fez parse do JSON: '\(data)'"]
            handlerConvertData(nil, NSError(domain: "convertData", code: 1, userInfo: userInfo))
        }
        handlerConvertData(parsedResult, nil)
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseAPIClient{
        struct Singleton{
            static var sharedInstance = ParseAPIClient()
        }
        return Singleton.sharedInstance
    }
    
}
