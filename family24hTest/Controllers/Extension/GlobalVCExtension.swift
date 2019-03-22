//
//  GlobalVCExtension.swift
//  family24hTest
//
//  Created by Filipe Merli on 22/03/2019.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.4)
        let activIndic = UIActivityIndicatorView.init(style: .whiteLarge)
        activIndic.startAnimating()
        activIndic.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(activIndic)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    class func displayWhiteSpin(naView: UIView) -> UIView {
        let whiteSpiView = UIView.init(frame: naView.bounds)
        whiteSpiView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        let indicador = UIActivityIndicatorView.init(style: .gray)
        indicador.startAnimating()
        indicador.center = whiteSpiView.center
        DispatchQueue.main.async {
            whiteSpiView.addSubview(indicador)
            naView.addSubview(whiteSpiView)
        }
        return whiteSpiView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}


public extension UIImage {
    func resize() -> UIImage {
        let altura: CGFloat = 40.0
        let proporcao = self.size.width / self.size.height
        let largura = altura * proporcao
        
        let novoTamanho = CGSize(width: largura, height: altura)
        let novoRetangulo = CGRect(x: 0, y: 0, width: largura, height: altura)
        
        UIGraphicsBeginImageContext(novoTamanho)
        self.draw(in: novoRetangulo)
        let imagemRedimensionada = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imagemRedimensionada!
        
    }
}
