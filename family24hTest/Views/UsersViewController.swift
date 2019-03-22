//
//  UsersViewController.swift
//  family24hTest
//
//  Created by Filipe Merli on 18/03/2019.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class UsersViewController: UITableViewController {
    
    // MARK: - Global vars
    
    var usuarios: [Users]?
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        let spinner = UITableViewController.displaySpinner(onView: self.view)
        ParseAPIClient.sharedInstance().getFetchJson(getHandler: { (usuarios, error) in
            if error != nil {
                self.mostrarAlerta("Verifique sua conexão com a internet em 'Configurações' e tente novamente.")
                UITableViewController.removeSpinner(spinner: spinner)
            } else {
                self.usuarios = usuarios
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UITableViewController.removeSpinner(spinner: spinner)
                }
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! TableViewCell
        let name = "\(usuarios?[indexPath.row].name!.first ?? "") \(usuarios?[indexPath.row].name!.last ?? "")"
        cell.setUserIcon(urlIconString: usuarios?[indexPath.row].picture!.thumbnail ?? "", name: name, bio: usuarios?[indexPath.row].bio!.mini ?? "")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let userBio = usuarios?[indexPath.row].bio!.mini {
            let approxWidthOfBio = view.frame.width - 25.0 - 50.0 - 15.0
            let size = CGSize(width: approxWidthOfBio, height: 1000.0)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let estimatedFrame = NSString(string: userBio).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return estimatedFrame.height + 60.0
        }
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetatilViewController
        detailVC.userId = usuarios?[indexPath.row].id ?? 0
        present(detailVC, animated: true, completion: nil)
    }
    
    // MARK: Alerta
    
    func mostrarAlerta(_ texto: String) {
        let oAlerta = UIAlertController(title: "Alerta", message: texto, preferredStyle: .alert)
        oAlerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(oAlerta, animated: true, completion: nil)
    }

}
