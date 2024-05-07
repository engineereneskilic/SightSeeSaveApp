//
//  ViewController.swift
//  gezgorkaydetApp
//
//  Created by Enes KILIC on 5/16/18.
//  Copyright © 2018 Enes KILIC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var girisbutton: UIButton!
     var kullanicilar:[Kullanicilar]? = nil
    
    
    
    
    @IBOutlet weak var giris_label: UILabel!
    
    
    @IBOutlet weak var programadiLabel: UILabel!

    

    
    @IBOutlet weak var girisButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // giris button
        hizliMetodlar.buttonTasarimi(gelenbutton: girisbutton)
        self.girisButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        
        self.giris_label.layer.masksToBounds = true
        self.giris_label.layer.cornerRadius = 3
        
        // program ismi label
        self.programadiLabel.layer.masksToBounds = true
        self.programadiLabel.layer.cornerRadius = 3
        //self.programadiLabel.backgroundColor = UIColor(red: 0.1961, green: 0.6314, blue: 1, alpha: 1.0)
        //self.programadiLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        self.programadiLabel.layer.borderWidth = 5
        self.programadiLabel.layer.borderColor = UIColor.white.cgColor
        
        /*
        self.programIcon.layer.masksToBounds = true
        self.programIcon.layer.cornerRadius = programIcon.frame.height / 2
        self.programIcon.layer.borderWidth = 3
        self.programIcon.layer.borderColor = UIColor.blue.cgColor
 */
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

