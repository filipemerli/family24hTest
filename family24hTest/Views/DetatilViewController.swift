//
//  DetatilViewController.swift
//  family24hTest
//
//  Created by Filipe Merli on 21/03/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit
import Photos

class DetatilViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var loadSpinner: UIActivityIndicatorView!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var userId: Int = 0
    var usuario: Users?
    var imageToSend: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        loadSpinner.startAnimating()
        ParseAPIClient.sharedInstance().getIdFetchJson(id: userId) { (usuario, error) in
            if error == nil {
                self.usuario = usuario?.first
                ParseAPIClient.sharedInstance().loadImages(url: (self.usuario?.picture?.medium)!) { (image, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.userIcon.image = image
                            self.loadSpinner.stopAnimating()
                            self.loadSpinner.alpha = 0.0
                            self.userNameLabel.text = "\(self.usuario?.name?.first ?? "")" + " \(self.usuario?.name?.last ?? "")"
                            self.emailLabel.text = "\(self.usuario?.email ?? "")"
                            self.locationLabel.text = "\(self.usuario?.location?.city ?? "")"
                            self.bioLabel.text = "\(self.usuario?.bio?.full ?? "")"
                        }
                        
                    } else {
                        self.mostrarAlerta("Verifique sua conexão com a internet em 'Configurações' e tente novamente.")
                    }
                }
            } else {
                self.mostrarAlerta("Verifique sua conexão com a internet em 'Configurações' e tente novamente.")
            }
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func backButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configView() {
        sendMessageButton.backgroundColor = .red
        sendMessageButton.layer.cornerRadius = 9
        userIcon.contentMode = .scaleAspectFit
        userIcon.layer.masksToBounds = false
        userIcon.layer.cornerRadius = self.userIcon.frame.height/2
        userIcon.clipsToBounds = true
        
    }
    @IBAction func sendImgae(_ sender: Any) {
        let spinner = UITableViewController.displaySpinner(onView: self.view)
        verificarPermissao { (result) in
            if result {
                UITableViewController.removeSpinner(spinner: spinner)
                self.pegarImagemLibrary()
            } else {
                UITableViewController.removeSpinner(spinner: spinner)
                self.alertaDeAjudaFotos()
            }
        }
        
    }
    
    func pegarImagemLibrary() {
        let spinner = UITableViewController.displaySpinner(onView: self.view)
        verificarPermissao(completion: { (permitido) in
            if permitido {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                UITableViewController.removeSpinner(spinner: spinner)
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                UITableViewController.removeSpinner(spinner: spinner)
            }
        })
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true) {
                let spinner = UITableViewController.displaySpinner(onView: self.view)
                self.imageToSend = image.resize()
                ParseAPIClient.sharedInstance().postRequest(imagem: self.imageToSend, postHandler: { (result, error) in
                    if result {
                        DispatchQueue.main.async {
                            self.mostrarAlerta("Imagem Enviada")
                        }
                    }
                    UITableViewController.removeSpinner(spinner: spinner)
                })
            }
        } else {
            self.mostrarAlerta("Erro ao acessar suas imagens")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Verificar permissao da PhotoLibrary
    
    func verificarPermissao(completion:@escaping (Bool)->Void) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    DispatchQueue.main.async(execute: {
                        UserDefaults.standard.set(true, forKey: "userPermiteFotos")
                        completion(true)
                    })
                } else {
                    UserDefaults.standard.set(false, forKey: "userPermiteFotos")
                    DispatchQueue.main.async(execute: {
                        completion(false)
                    })
                }
            })
        } else {
            DispatchQueue.main.async(execute: {
                UserDefaults.standard.set(true, forKey: "userPermiteFotos")
                completion(true)
            })
        }
    }
    
    // MARK: Alerta
    
    func mostrarAlerta(_ texto: String) {
        let oAlerta = UIAlertController(title: "Alerta", message: texto, preferredStyle: .alert)
        oAlerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(oAlerta, animated: true, completion: nil)
    }
    
    func alertaDeAjudaFotos() {
        let oAlerta = UIAlertController(title: "Ajuda", message: "Para permitir acesso a sua biblioteca de fotos feche este app, vá em Ajustes > Privacidade > Fotos > Frases Divinas e permita Leitura e Gravação.", preferredStyle: .alert)
        oAlerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(oAlerta, animated: true, completion: nil)
    }

}
