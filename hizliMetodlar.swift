//
//  hizliMetodlar.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit
var onay:Bool=false
class hizliMetodlar: NSObject {
    
    class func buttonTasarimi(gelenbutton: UIButton){
        gelenbutton.backgroundColor = UIColor(red: 0.1961, green: 0.6314, blue: 1, alpha: 1.0)
        gelenbutton.layer.cornerRadius = gelenbutton.frame.height / 2
        gelenbutton.setTitleColor(UIColor.white, for: .normal)
        
        gelenbutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        gelenbutton.layer.shadowRadius = 6
        gelenbutton.layer.borderWidth = 2
        gelenbutton.layer.borderColor = UIColor.white.cgColor
    }
    
    class func MesajGoster(ekran:UIViewController, baslik:String, icerik:String){
        
        let alert = UIAlertController(title: baslik, message: icerik, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        ekran.present(alert, animated: true, completion: nil)
    }
    
    

    
    class func TextBosMu(gelen: UITextField) -> Bool{
        
        if(gelen.text == ""){
            return true;
        }else{
            return false;
        }
        
    }
    class func TextFieldIconEkle(textfield: UITextField, andImage img:UIImage){
        let solResim = UIImageView(frame: CGRect(x: 20, y: 20, width: 25, height: 25))
        solResim.image = img
        textfield.leftView = solResim
        textfield.leftViewMode = .always
    }
    class func emailKontrol(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        ";~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }}
