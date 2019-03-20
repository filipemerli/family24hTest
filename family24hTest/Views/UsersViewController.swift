//
//  UsersViewController.swift
//  family24hTest
//
//  Created by Filipe Merli on 18/03/2019.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class UsersViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    var usersData: Root?
    var usuarios: [Users]?
    //var users: Users?
    
    func fetchJSON() {
        let urlString = "http://testmobiledev.eokoe.com/users"
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35", forHTTPHeaderField: "X-API-Key")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url:", error)
                    return
                }
                guard let detailData = data else { return }
                do {
                    let decoder = JSONDecoder()
                    //self.usuarios = try decoder.decode(Root.self, from: data)
                    let jsonData = try decoder.decode(Root.self, from: detailData)
                    //print(jsonData.results)
                    self.usuarios = jsonData.results
                    //print(self.usuarios as Any)
                    self.tableView.reloadData()
                } catch let jsonError {
                    print("Failed to decode:", jsonError)
                }
            }
            }.resume()
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        cell.textLabel?.text = "\(usuarios?[indexPath.row].name.first ?? "") \(usuarios?[indexPath.row].name.last ?? "")"
        cell.detailTextLabel?.text = usuarios?[indexPath.row].bio.mini
        return cell
    }

}
