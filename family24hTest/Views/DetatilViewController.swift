//
//  DetatilViewController.swift
//  family24hTest
//
//  Created by Filipe Merli on 21/03/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class DetatilViewController: UIViewController {

    @IBOutlet weak var userIconView: UIImageView!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIconView.image = #imageLiteral(resourceName: "Location")
        sendMessageButton.backgroundColor = .red
        

    }
    
    
    @IBAction func backButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
