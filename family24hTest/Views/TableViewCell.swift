//
//  TableViewCell.swift
//  family24hTest
//
//  Created by Filipe Merli on 20/03/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIconS: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    
    
    func setUserIcon(urlIconString: String, name: String, bio: String) {
        userName.text = name
        userBio.text = bio
        ParseAPIClient.sharedInstance().loadImages(url: urlIconString) { (image, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.userIconS.image = image
                    self.userIconS.contentMode = .scaleAspectFit
                    self.userIconS.layer.masksToBounds = false
                    self.userIconS.layer.cornerRadius = self.userIconS.frame.height/2
                    self.userIconS.clipsToBounds = true
                }
                
            } else {
                //tratar erro
            }
        }
    }
}
