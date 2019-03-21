//
//  APIClient.swift
//  family24hTest
//
//  Created by Filipe Merli on 19/03/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

class ParseAPIClient: NSObject {
    
    // MARK: Properties
    
    var session = URLSession.shared
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    func getFetchJson(getHandler: @escaping (_ result: [Users]?, _ error: Error?) -> Void) {
        let urlString = "\(ParseConstants.parseUrl)" + "\(ParseConstants.getStart)" + "\(ParseConstants.getLimit)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue(ParseConstants.apiKey, forHTTPHeaderField: ParseConstants.headerAPIKey)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                getHandler(nil, error)
                print("Falha no GET:", error)
                return
            }
            guard let detailData = data else {
                getHandler(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Root.self, from: detailData)
                getHandler(jsonData.results, nil)
            } catch let jsonError {
                getHandler(nil, error)
                print("Falha no Decode:", jsonError)
            }
        }.resume()
    }
    
    func loadImages(url: String, loadHandler: @escaping (_ result: UIImage?, _ error: Error?) -> Void) {
        let imageURL = URL(string: url)!
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if error == nil {
                let downloadedImage = UIImage(data: data!)
                loadHandler(downloadedImage, nil)
            } else {
                loadHandler(nil, error)
            }
        }.resume()
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseAPIClient{
        struct Singleton{
            static var sharedInstance = ParseAPIClient()
        }
        return Singleton.sharedInstance
    }
    
    
}
