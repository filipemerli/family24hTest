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
    
    var usersData: Root?
    var usuarios: [Users]?

    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        ParseAPIClient.sharedInstance().getFetchJson(getHandler: { (usuarios, error) in
            if error != nil {
                self.mostrarAlerta("Verifique sua conexão com a internet em 'Configurações' e tente novamente.")
                activityIndicator.removeFromSuperview()
            } else {
                self.usuarios = usuarios
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
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
        let name = "\(usuarios?[indexPath.row].name.first ?? "") \(usuarios?[indexPath.row].name.last ?? "")"
        //cell.detailTextLabel?.text = usuarios?[indexPath.row].bio.mini
        cell.setUserIcon(urlIconString: usuarios?[indexPath.row].picture.thumbnail ?? "", name: name, bio: usuarios?[indexPath.row].bio.mini ?? "")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("TO AQUI")
        if let userBio = usuarios?[indexPath.row].bio.mini {
            print("Dentro da BIO")
            let approxWidthOfBio = view.frame.width - 25.0 - 50.0 - 15.0
            let size = CGSize(width: approxWidthOfBio, height: 1000.0)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let estimatedFrame = NSString(string: userBio).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            print("TAMANHO = \(estimatedFrame.height + 60.0)")
            return estimatedFrame.height + 60.0
        }
        return 140.0
    }
    
    //override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("LINK = \(usuarios?[indexPath.row].picture.thumbnail ?? "DEU RUIM")")
    //}
    
    // MARK: Alerta
    
    func mostrarAlerta(_ texto: String) {
        let oAlerta = UIAlertController(title: "Alerta", message: texto, preferredStyle: .alert)
        oAlerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(oAlerta, animated: true, completion: nil)
    }

}
